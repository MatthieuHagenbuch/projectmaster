
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectmaster/pages/Authentification/addUser.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/models/users.dart';
import 'package:projectmaster/pages/Calendar/calendar_createEvent.dart';
import 'package:projectmaster/widgets/appBar.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Authentification/AuthGate.dart';
import 'calendar_detailsEvents.dart';

class CalendarDisplay extends StatefulWidget {

  final String? uId;
  CalendarDisplay(this.uId);
 
  @override
  CalendarDisplayState createState() => CalendarDisplayState();
}

class CalendarDisplayState extends State<CalendarDisplay> {

 List<Color> _colorCollection = <Color>[];
 MeetingDataSource? events;    
 var userRole1;
 var id;
 bool isInitialLoaded = false;


  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
      
    });
       getUserRole(widget.uId).then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
      
    });
    
    super.initState();
  }
   var pickId;
  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await databaseReference
        .collection("events")
        .get();
    
    List<EventsModel> list = snapShotsValue.docs
        .map((e) => EventsModel(
            id: e.id,
            activity: e.data()['activity'].toString(),
            startEvent :e.data()['startEvent'].toDate(),
            endEvent : e.data()['endEvent'].toDate(),
            aditionalInfo : e.data()['aditionalInfo'].toString(),
             course : e.data()['course'].toString(),
              language : e.data()['language'].toString(),
               location : e.data()['location'].toString(),
                price : e.data()['price'].toDouble(),
                sport : e.data()['sport'].toString(),
                numberOfPeopleMin : e.data()['numberOfPeopleMin'],
                numberOfPeopleMax : e.data()['numberOfPeopleMax'],
                numberOfPeople : e.data()['numberOfPeople'],
                
                ))
               
        .toList();
  
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  
Future<void> getUserRole(uId) async {
    FirebaseFirestore.instance
        .collection("users")
        .where("uId", isEqualTo: uId)
        .get()
        .then((value) => {
           if (value != null)
           {
            
            userRole1 = value.docs.first.data()['role'].toString(),
            id = value.docs.first.id,
           }else{
            print('Document does not exist on the database'),
           }
        });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
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
         floatingActionButton: FloatingActionButton(
          onPressed: () {
          String uId;
          

          if(userRole1 == 'client'){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('No access'),
                content: const Text('Sorry, you not access to add on event'),
                actions: <Widget>[
                  TextButton(onPressed: () =>
                   Navigator.pop(context, 'OK'),
                   child: const Text('OK'),
                  ),
                ],
              )
            );

          }else{
         Navigator.push(
          
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEvent(),           
                    ));
          }
         },
        //child: const Text('+'),
        child : Icon(Icons.add),
        backgroundColor: Colors.cyan
         ),
         
    );
  }
  
  void calendarTapped(CalendarTapDetails calendarTapDetails, ) {
  if (calendarTapDetails.targetElement == CalendarElement.appointment ||
      calendarTapDetails.targetElement == CalendarElement.agenda) {
      EventsModel appointmentDetails = calendarTapDetails.appointments![0];
     

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageEvent(eventDetails:appointmentDetails, uId: id,)),
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
