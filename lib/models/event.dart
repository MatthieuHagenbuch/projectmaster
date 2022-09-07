
class EventsModel{

  late final String activity;
  final DateTime startEvent;
  final DateTime endEvent;
  late final String aditionalInfo;
  final String course;
  final String language;
  final String location;
  final int price;
  final String sport;
  final int numberOfPeopleMin;
  final int numberOfPeopleMax;

  EventsModel({required this.activity, required this.startEvent, required this.endEvent, required this.aditionalInfo,required this.course,required this.language,
  required this.location, required this.price, required this.sport, required this.numberOfPeopleMin, required this.numberOfPeopleMax});

}