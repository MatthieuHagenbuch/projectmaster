// Author - Océane

import 'package:flutter/material.dart';
import 'package:projectmaster/get_data.dart';
import 'package:projectmaster/widgets/appbar.dart';

// Page with calendar
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: GetData(),
      // body: CalendarDisplay(),
      // body: AddEvent(),
    );
  }
}
