import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmaster/widgets/appBar.dart';

const dhint = 'Choose';

enum CoursType { HP, BC }

enum SportType { Ski, Snowboard }

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEventState();
}

@override
class _AddEventState extends State<AddEvent> {
  var _Field = <Widget>[];

  final formKey = GlobalKey<FormState>();

  final activityController = TextEditingController();

  @override
  void dispose() {
    activityController.dispose();
    super.dispose();
  }

  DateTime date = DateTime.now();

  String getDate() {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  late VoidCallback onClicked;

  String? _activity;

// declare constant for drop-down menus
  static const stationItems = <String>['Verbier', 'Montana'];
  static const activityItems = <String>['Rando', 'Free'];
  static const sportItems = <String>['Ski', 'Snowboard'];
  static const langueItems = <String>['English', 'Français'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          key: formKey,
          children: [
            ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('Date'),
                textColor: Colors.black,
                trailing: TextButton(
                  onPressed: () => pickDate(context),
                  child: Text(getDate()),
                )),
            ListTile(
              leading: const Icon(Icons.local_activity),
              title: const Text('Activity'),
              trailing: DropdownButton<String>(
                value: _activity,
                hint: const Text(dhint),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _activity = newValue);
                  }
                },
                items: _dropDownActivityItems,
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
            FloatingActionButton(
              backgroundColor: Colors.cyan,
              child: const Icon(Icons.add),
              onPressed: () async {
                FirebaseFirestore.instance.collection('events').add({
                  'activity': _activity,
                  'startEvent': date,
                  'course': _coursType.toString(),
                  //'sport': _sportType
                });
              },
            )
          ],
        ));
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
