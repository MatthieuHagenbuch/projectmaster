import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmaster/widgets/button_widget.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime date = DateTime.now();
  late final String title;
  late final String text;
  late final VoidCallback onClicked;


  String getText() {
      return DateFormat('MM/dd/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(

        title: 'Date',
        text: getText(),
        onClicked: () => pickDate(context),
       
      );
     

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
