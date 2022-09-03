// Author - Océane

import 'package:flutter/material.dart';
import 'package:projectmaster/pages/calendar_allEvents.dart';
import 'package:projectmaster/widgets/appbar.dart';

// Page to call calendar
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: CalendarDisplay(),
    );
  }
}
