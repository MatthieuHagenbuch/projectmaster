
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/pages/Calendar/calendar_allEvents.dart';

import '../../widgets/appBar.dart';

class AllEventsDisplay extends StatefulWidget {
 const AllEventsDisplay({Key? key}) : super(key: key);
  @override
  AllEventsDisplayState createState() => AllEventsDisplayState();
}

class AllEventsDisplayState extends State<AllEventsDisplay> {

  

    final Stream<List<EventsModel>> _eventsStream =
      FirebaseFirestore.instance.collection('events').snapshots().map((snapshot) => snapshot.docs.map((doc) => EventsModel.fromJson(doc.data())).toList());

  String searchText = '';  

  List<Map<String, dynamic>> list = [];
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<List<EventsModel>>(

      stream: _eventsStream,

      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! Message : ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading"),
          );
        }

        List<EventsModel> events = snapshot.data!;

        if(searchText != ''){
          events = events.where((element) => element.activity.toLowerCase().contains(searchText.toLowerCase())).toList();
        }

        for (var event in events) {
          debugPrint('event : $event');
        }    
        
        return Scaffold(
          appBar: MyAppBar(),
          body: Container(
           child: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
    children: [
          Container(
            height: 50,
           
            child: TextField(
               controller: _searchController,
               decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
               ),

               onChanged: (value) {
                setState(() {
                  searchText = value;
    });
  }
  ),
),


      Container(
        child: Column(   
          children: events.map((EventsModel event) {      
        
          return Container(
            margin: EdgeInsets.all(10),
            height: 230,
            width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
           boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
 ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  event.picture
                ),
                fit: BoxFit.cover,
              ),
            ),
           
          ),
Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 event.activity,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '\$' +event.price.toString(),
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.location,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'per person',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(width: 20),
                Text(
                  event.numberOfPeople.toString() + ' Nombre de personne minimum',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],

      ),);
          }).toList(),
           )
           )
    ],
           )
           )
           ));
      }
    );
    }

    static Future<List<Map<String, dynamic>>> search(String activity) async{
      QuerySnapshot<Map<String,dynamic>> response = await FirebaseFirestore.instance
      .collection('events')
      .where('activity', isEqualTo: activity)
      .get();
      return response.docs.map((e) => e.data()).toList();
    }

    static Future<List<Map<String, dynamic>>> gets() async{
      QuerySnapshot<Map<String,dynamic>> response = await FirebaseFirestore.instance
      .collection('events')
      .get();
      return response.docs.map((e) => e.data()).toList();
    }

  }