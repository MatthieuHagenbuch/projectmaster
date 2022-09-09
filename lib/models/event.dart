/*
 Author : Océane - Matthieu
 Model about events
*/
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel{

  final databaseReference = FirebaseFirestore.instance;

  final String id;
  final String activity;
  final DateTime startEvent;
  final DateTime endEvent;
  final String aditionalInfo;
  final String course;
  final String language;
  final String location;
  final double price;
  final String sport;
  final int numberOfPeopleMax;
  final int numberOfPeople;
  String picture;

  //Default constuctor
  EventsModel({required this.id, required this.activity, required this.startEvent, required this.endEvent, required this.aditionalInfo,required this.course,required this.language,
  required this.location, required this.price, required this.sport, required this.numberOfPeopleMax, required this.numberOfPeople, required this.picture
  });

  //Translate an Event object to JSON
  EventsModel.fromJson(json) : this(
    id: '',
    activity: json!['activity'].toString(),
    startEvent :json!['startEvent'].toDate(),
    endEvent : json!['endEvent'].toDate(),
    aditionalInfo : json!['aditionalInfo'].toString(),
    course : json!['course'].toString(),
    language : json!['language'].toString(),
    location : json!['location'].toString(),
    price : json!['price'].toDouble(),
    sport : json!['sport'].toString(),
    numberOfPeopleMax : json!['numberOfPeopleMax'],
    numberOfPeople : json!['numberOfPeople'],
    picture: json!['picture'],
  );

  // Readable event object
  @override
  String toString() {
    return 'Event:{ id: $id, activity: $activity, startEvent: $startEvent, endEvent: $endEvent}';
  }
} 