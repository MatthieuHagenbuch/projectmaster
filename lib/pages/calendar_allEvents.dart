import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/pages/calendar_createEvent.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'calendar_detailsEvents.dart';

class CalendarDisplay extends StatefulWidget {
  const CalendarDisplay({Key? key}) : super(key: key);
 
  @override
  CalendarDisplayState createState() => CalendarDisplayState();
}

class CalendarDisplayState extends State<CalendarDisplay> {

  MeetingDataSource? events;
  late EventsModel event;
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
            startEvent :e.data()['startEvent'].toDate(),
            endEvent : e.data()['endEvent'].toDate(),
            aditionalInfo : e.data()['aditionalInfo'].toString(),
             course : e.data()['course'].toString(),
              language : e.data()['language'].toString(),
               location : e.data()['location'].toString(),
                price : e.data()['price'],
                sport : e.data()['sport'].toString(),
                numberOfPeopleMin : e.data()['numberOfPeopleMin'],
                numberOfPeopleMax : e.data()['numberOfPeopleMax']))
        .toList();
  
    setState(() {
      events = MeetingDataSource(list);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(

         child : SfCalendar(
                view: CalendarView.month,
                firstDayOfWeek: 1,
                onTap: calendarTapped,   
          dataSource: events,
            allowedViews: const [
              CalendarView.month,
                CalendarView.day,
                CalendarView.week,
                CalendarView.workWeek,
                CalendarView.timelineDay,
                CalendarView.timelineWeek,
                CalendarView.timelineWorkWeek,
                CalendarView.timelineMonth,
                CalendarView.schedule
              ],
              
          monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            agendaViewHeight: 300,
            showTrailingAndLeadingDates: false,
          ), 
          
          todayHighlightColor: Colors.cyan,
          //add collection
         ),
         ),
         floatingActionButton: FloatingActionButton(onPressed: () {
        
         Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEvent(),           
                    ));
        }, child: const Text('add'), backgroundColor: Colors.cyan
        ),
    );
  } 
  
  void calendarTapped(CalendarTapDetails calendarTapDetails, ) {
  if (calendarTapDetails.targetElement == CalendarElement.appointment ||
      calendarTapDetails.targetElement == CalendarElement.agenda) {
      EventsModel appointmentDetails = calendarTapDetails.appointments![0];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageEvent(eventDetails:appointmentDetails)),
    );
  }
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
    @override
  DateTime getEndTime(int index) {
    return appointments![index].endEvent;
  }
}