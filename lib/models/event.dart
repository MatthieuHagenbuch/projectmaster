
class EventsModel{

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

  EventsModel({required this.id, required this.activity, required this.startEvent, required this.endEvent, required this.aditionalInfo,required this.course,required this.language,
  required this.location, required this.price, required this.sport, required this.numberOfPeopleMin, required this.numberOfPeopleMax, required this.numberOfPeople, 
  });

}