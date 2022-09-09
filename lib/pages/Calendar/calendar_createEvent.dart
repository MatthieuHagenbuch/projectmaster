import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmaster/widgets/appBar.dart';

/*
 Author : Océane - Matthieu
 Display page event and add an event
*/

const dhint = 'Choose';
enum CoursType { HP, BC }
enum SportType { Ski, Snowboard }

enum CoursType { HP, BC }

enum SportType { Ski, Snowboard }

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEventState();
}

@override
class _AddEventState extends State<AddEvent> {

  final activityController = TextEditingController();

  @override
  void dispose() {
    activityController.dispose();
    super.dispose();
  }


  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  String getDateStartEvent() {
    return DateFormat('MM/dd/yyyy').format(startDate);
  }
  String getDateEndEvent() {
    return DateFormat('MM/dd/yyyy').format(endDate);

  }

  late VoidCallback onClicked;


  String? activity;
  String? additionalInfo = 'Come in large numbers';
  String? language = 'English';
  int numberOfPeople = 0;
  int numberOfPeopleMax = 50;
  String picture = 'https://www.snowmagazine.com/images/ski-resorts/switzerland/villars-604914-resort.jpg';
  double price = 2000;
  String? location;
  

// declare constant for drop-down menus
  static const stationItems = <String>['Verbier', 'Montana', 'Villar'];

  static const activityItems = <String>['Rando', 'Free'];
  static const sportItems = <String>['Ski', 'Snowboard'];
  static const langueItems = <String>['English', 'Français'];

//Values for radio buttons
  CoursType? _coursType = CoursType.HP;
  SportType? _sportType = SportType.Ski;

//Values for radio buttons
  CoursType? _coursType = CoursType.HP;
  SportType? _sportType = SportType.Ski;

// create the different drop-down lists
  final List<DropdownMenuItem<String>> _dropDownActivityItems = activityItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

      final List<DropdownMenuItem<String>> _dropDownStationItems = stationItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          children: [
            ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('Date'),
                textColor: Colors.black,
                trailing: TextButton(

                  onPressed: () => pickDateAddEvent(context),
                  child: Text(getDateStartEvent()),
                )),

          ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('Date'),
                textColor: Colors.black,
                trailing: TextButton(
                  onPressed: () => pickDateEndEvent(context),
                  child: Text(getDateEndEvent()),

                )),
            ListTile(
              leading: const Icon(Icons.local_activity),
              title: const Text('Activity'),
              trailing: DropdownButton<String>(
                value: activity,
                hint: const Text(dhint),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => activity = newValue);
                  }
                },
                items: _dropDownActivityItems,
              ),
            ),
             ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Location'),
              trailing: DropdownButton<String>(
                value: location,
                hint: const Text(dhint),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => location = newValue);
                  }
                },
                items: _dropDownStationItems,
              ),
            ),

            const ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Cours Type'),
              
            ),
            ListTile(
              title: const Text('HP'),
              leading: Radio<CoursType>(
                value: CoursType.HP,
                groupValue: _coursType,
                onChanged: (CoursType? value) {
                  setState(() {
                    _coursType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('BC'),
              leading: Radio<CoursType>(
                value: CoursType.BC,
                groupValue: _coursType,
                onChanged: (value) {
                  setState(() {
                    _coursType = value;
                  });
                },
              ),
            ),
            const ListTile(
              leading: Icon(Icons.snowboarding),
              title: Text('Sport Type'),
            ),
            ListTile(
              title: const Text('Ski'),
              leading: Radio<SportType>(
                value: SportType.Ski,
                groupValue: _sportType,
                onChanged: (SportType? value) {
                  setState(() {
                    _sportType = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Snowboard'),
              leading: Radio<SportType>(
                value: SportType.Snowboard,
                groupValue: _sportType,
                onChanged: (SportType? value) {
                  setState(() {
                    _sportType = value;
                  });
                },
              ),
            ),

            //button to add value in firestore in "events" collection

            FloatingActionButton(
              backgroundColor: Colors.cyan,
              child: const Icon(Icons.add),
              onPressed: () async {
                FirebaseFirestore.instance.collection('events').add({

                  'activity': activity,
                  'startEvent': startDate,
                  'endEvent' : endDate,
                  'course': _coursType.toString(),
                  'sport': _sportType.toString(),
                  'language': language,
                  'location': location,
                  'numberOfPeople': numberOfPeople,
                  'numberOfPeopleMax' : numberOfPeopleMax,
                  'picture': picture,
                  'additionalInfo' : additionalInfo,
                  'price': price,

                });
              },
            )
          ],
        ));

  }

 //Widget "showDatePicker" to display "startEvent"
  Future pickDateAddEvent(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => startDate = newDate);

  }

//Widget "showDatePicker" to display "endEvent"
    Future pickDateEndEvent(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

     setState(() => endDate = newDate);
    
  }
}
