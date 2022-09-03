
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectmaster/models/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarDisplay extends StatefulWidget {
  const CalendarDisplay({Key? key}) : super(key: key);

  @override
  CalendarDisplayState createState() => CalendarDisplayState();
}

class CalendarDisplayState extends State<CalendarDisplay> {

  MeetingDataSource? events;
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }
   
  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await databaseReference
        .collection("events")
        .get();
    
    List<EventsModel> list = snapShotsValue.docs
        .map((e) => EventsModel(
            activity: e.data()['activity'].toString(),
            startEvent :e.data()['startEvent'].toDate()))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          firstDayOfWeek: 1,
          
          //add collection
          dataSource: events,
            ),
        ),
        floatingActionButton: 
        FloatingActionButton(onPressed: () {
        
        }, child: Text('add'), backgroundColor: Colors.cyan
        ),
    );
  } 
}

class MeetingDataSource extends CalendarDataSource {
  
  MeetingDataSource(List<EventsModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startEvent;
  }

  @override
  String getSubject(int index) {
    return appointments![index].activity;
  }
  
}