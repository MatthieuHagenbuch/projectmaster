import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/widgets/appBar.dart';

import 'package:transparent_image/transparent_image.dart'

show kTransparentImage;
class ManageEvent extends StatelessWidget {

EventsModel? eventDetails;
ManageEvent({this.eventDetails});

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

        
     
        // ADD EDIT DATE AND TIME https://www.syncfusion.com/kb/11204/how-to-design-and-configure-your-appointment-editor-in-flutter-calendar
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
            eventDetails!.numberOfPeopleMin.toString(),
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
          leading: const Icon(Icons.info),
            title: const Text('AditionalInfo'),

          subtitle: Text(
            eventDetails!.aditionalInfo,
        ),
        ),
        const Divider(
          height: 1.0,
          thickness: 1,
        ),
            ],
        ),
       )
    );
  }
}