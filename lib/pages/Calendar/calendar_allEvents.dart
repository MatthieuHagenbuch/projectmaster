import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/pages/Calendar/calendar_createEvent.dart';
import 'package:projectmaster/widgets/appBar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'calendar_detailsEvents.dart';

/*
 Author : Océane
 Display calendar with events load from Firestore
*/
class CalendarDisplay extends StatefulWidget {

  final String? uId;
  // ignore: use_key_in_widget_constructors
  const CalendarDisplay(this.uId);
 
  @override
  CalendarDisplayState createState() => CalendarDisplayState();
}

class CalendarDisplayState extends State<CalendarDisplay> {

 MeetingDataSource? events;    
 var userRole;
 var id;
 var userName;
 
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
   
  // Retrieve the "events" collection from firestore in a list
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
                numberOfPeopleMax : e.data()['numberOfPeopleMax'],
                numberOfPeople : e.data()['numberOfPeople'],
                 picture : e.data()['picture'],
                ))
               
        .toList();
  
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  // Retrieve "role" and "id" the "users" collection from firestore 
Future<void> getUserRole(uId) async {
    FirebaseFirestore.instance
        .collection("users")
        .where("uId", isEqualTo: uId)
        .get()
        .then((value) => {
           // ignore: unnecessary_null_comparison
           if (value != null)
           {    
            userRole = value.docs.first.data()['role'].toString(),
            id = value.docs.first.id,
           }else{
            // ignore: avoid_print
            print('Document does not exist on the database'),
           }
        });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body : Center(

        //Use library syncfusion_flutter_calendar to build Calendar
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
         ),
         ),
         
         //Do not let the user add an event
         floatingActionButton: FloatingActionButton(
          onPressed: () {

          if(userRole == 'client'){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('No access'),
                content: const Text('Sorry, you can not add on event'),
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
        backgroundColor: Colors.cyan,
        child : const Icon(Icons.add)
         ),
         
    );
  }
  
  // Access the details of an event by taking the fields with
  void calendarTapped(CalendarTapDetails calendarTapDetails, ) {
  if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      EventsModel appointmentDetails = calendarTapDetails.appointments![0];
     

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageEvent(eventDetails:appointmentDetails, uId: id)),
    );
  }
}
}

// Allows you to display the different information on the calendar
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