import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmaster/models/event.dart';
import 'package:projectmaster/widgets/appBar.dart';

const dhint = 'Choose';

class AddEvent2 extends StatefulWidget {
  const AddEvent2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEvent2State();
}
@override
class _AddEvent2State extends State<AddEvent2> {
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
  static const activityItems = <String>['Rando', 'Free'];

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
    EventsModel items = EventsModel(
      activity: _activity,
      startEvent: date,
    );



    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          key: formKey,
          children: [
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: const Text('Date'),
              textColor: Colors.black,
              trailing: 
              TextButton(
                   onPressed: () => pickDate(context), 
                   child: Text(getDate()),
                )
              ),

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
            TextFormField(
            controller: activityController,
            validator: (activity) {
              if (activity!.isEmpty) {
                return "Address is required";
              }
             
            }
          ),



            FloatingActionButton(
              backgroundColor: Colors.cyan,
              child: const Icon(Icons.add),
              onPressed: () async{
                FirebaseFirestore.instance
                .collection('events')
                .add({'activity': _activity, 'startEvent': date} );
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
