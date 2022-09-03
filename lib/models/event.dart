import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel{

  
  final String? activity;
  final DateTime? startEvent;


  EventsModel({this.activity, this.startEvent});


  factory EventsModel.fromJson(Map<String, dynamic> json) =>
      _eventFromJson(json);
 
 
  Map<String, dynamic> toJson() => _eventToJson(this);

}

EventsModel _eventFromJson(Map<String, dynamic> json) {
  return EventsModel(
    activity : (json['activity'] as String),
    startEvent: (json['startEvent'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> _eventToJson(EventsModel instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'date': instance.startEvent,
    };
