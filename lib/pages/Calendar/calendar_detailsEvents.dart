
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/pages/Calendar/calendar_allEvents.dart';
import 'package:projectmaster/widgets/appBar.dart';

import 'package:transparent_image/transparent_image.dart'

/*
 Author : Océane
 Display page with detail about one event selected
*/

show kTransparentImage;
class ManageEvent extends StatelessWidget {

final String? uId;
EventsModel? eventDetails;
ManageEvent({Key? key, this.eventDetails, required this.uId}) : super(key: key);
List<String> eventsByUser = [];

 @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: const MyAppBar(),
       body: Container(
        color: Colors.white, 
        child: ListView(
        padding: const EdgeInsets.all(10.0),
            children: <Widget>[

        ListTile(
          title: Text(eventDetails!.location.toString(),
          style: GoogleFonts.laila(
            textStyle: Theme.of(context).textTheme.headline6,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.cyan,
          ),
              textAlign : TextAlign.center,
          ),

        ),
          Card(
           child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage, 
            image: 'https://www.snowmagazine.com/images/ski-resorts/switzerland/villars-604914-resort.jpg')
          ),
        
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
          leading: const Icon(Icons.local_activity),
          title: const Text('Activity'),
          subtitle: Text(
            eventDetails!.activity,
          ),
        ),

        ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Icon(Icons.calendar_month),
            title: const Text('StartEvent'),
            subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    
                    flex: 7,
                    child: GestureDetector(
                        child: Text(
                            DateFormat('EEE, MMM dd yyyy')
                                .format(eventDetails!.startEvent),
                            textAlign: TextAlign.left),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child:
                           GestureDetector(
                              child: Text(
                                DateFormat('hh:mm a').format(eventDetails!.startEvent),
                                textAlign: TextAlign.right,
                              ),
                )),
                
                ])),
        ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Icon(Icons.calendar_month),
            title: const Text('StartEvent'),
            subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                        child: Text(
                          DateFormat('EEE, MMM dd yyyy').format(eventDetails!.startEvent),
                          textAlign: TextAlign.left,
                        ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child
                          : GestureDetector(
                              child: Text(
                                DateFormat('hh:mm a').format(eventDetails!.endEvent),
                                textAlign: TextAlign.right,
                              ),    )),
                ])),
            
         ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.sports),
            title: const Text('Course'),

          subtitle: Text(
            eventDetails!.course,
        ),
        ),

        ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.sports),
            title: const Text('Sport'),

          subtitle: Text(
            eventDetails!.course,
        ),
        ),

         ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.description),
            title: const Text('Language'),

          subtitle: Text(
            eventDetails!.language,
        ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.savings),
            title: const Text('Price'),

          subtitle: Text(
            eventDetails!.price.toString(),
        ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.people),
            title: const Text('MinPeople'),

          subtitle: Text(
            eventDetails!.numberOfPeople.toString(),
        ),
        ),
         ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.people),
            title: const Text('MaxPeople'),

          subtitle: Text(
            eventDetails!.numberOfPeopleMax.toString(),
        ),
        ),
        
         ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.people),
            title: const Text('Subscribe'),

          subtitle: Text(
            eventDetails!.numberOfPeople.toString(),
        ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.info),
            title: const Text('AditionalInfo'),

          subtitle: Text(
            eventDetails!.aditionalInfo,
        ),
        ),     
            ],         
        ),   
       ),

       //User can subscribe in an event
          // - if event is full, the user is not subscribe
       floatingActionButton: FloatingActionButton.extended(onPressed: (){
        var result = addPerson(eventDetails!.id,eventDetails!.numberOfPeople, 
        eventDetails!.price, eventDetails!.numberOfPeopleMax, uId);
        switch (result){
          case (-1) :
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Sorry this event is full'),
                actions: <Widget>[
                  TextButton(onPressed: () =>
                   Navigator.pop(context, 'OK'),
                   child: const Text('OK'),
                  ),
                ],
              )
            );
            break;
            case(1) :
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Thank you for your subscribe'),
                content: const Text('Thank you for your registration. You can find the different information about your registration under the tab "My reservations" '),
                actions: <Widget>[
                  TextButton(onPressed: () =>
                   Navigator.pop(context, 'OK'),
                   child: const Text('OK'),
                  ),
                ],
              )
            );
        }
          },
        label: const Text('Subscribe'),
        backgroundColor: Colors.cyan
    ),
    );
    
  }

  //Update data in firestore
  int addPerson(String idEvent,int people, double price, int peopleMax, String? idUser ) {
    if(people >= peopleMax){
      return -1;
    }else{

    var newNumberOfPeople = people+1;
    var newPrice = price/people;
    eventsByUser.add(idEvent);
  
    try{
      FirebaseFirestore.instance.collection('events').doc(idEvent).update({
        'numberOfPeople' : newNumberOfPeople,
        'price' : newPrice,
      // ignore: avoid_print
      }).then((value) => print('data update'));
    }catch(e) {
      // ignore: avoid_print
      print(e.toString());
    }
      try{
        //récupérer l'id
         FirebaseFirestore.instance.collection('events').doc(idEvent).update({
          'subscriber' : FieldValue.arrayUnion([idUser]),
                
      }).then((value) => print('data update'));
    }catch(e) {
      print(e.toString());
    }
    }
    return 1;
  }
}