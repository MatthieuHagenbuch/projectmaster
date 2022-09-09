
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel{

  final databaseReference = FirebaseFirestore.instance;
/*
  late final String _id;
  String get id => _id;
  set id(String value){
    _id = value;
  }
  */
 late final String id;
  late final String activity;
  final DateTime startEvent;
  final DateTime endEvent;
  late final String aditionalInfo;
  final String course;
  final String language;
  final String location;
  final double price;
  final String sport;
  final int numberOfPeopleMin;
  final int numberOfPeopleMax;
  late final int numberOfPeople;
  late String picture;

  EventsModel({required this.id, required this.activity, required this.startEvent, required this.endEvent, required this.aditionalInfo,required this.course,required this.language,
  required this.location, required this.price, required this.sport, required this.numberOfPeopleMin, required this.numberOfPeopleMax, required this.numberOfPeople, required this.picture
  });

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
    numberOfPeopleMin : json!['numberOfPeopleMin'],
    numberOfPeopleMax : json!['numberOfPeopleMax'],
    numberOfPeople : json!['numberOfPeople'],
    picture: json!['picture'],
  );

    @override
  String toString() {
    return 'Event:{ id: $id, activity: $activity, startEvent: $startEvent, endEvent: $endEvent}';
  }
} 
