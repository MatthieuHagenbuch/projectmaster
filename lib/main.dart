import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectmaster/get_data.dart';
import 'package:projectmaster/pages/calendar/main_calendar.dart';
import 'package:projectmaster/widgets/appbar.dart';

// Initialize firebase with flutter app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // build interface
  @override
  Widget build(BuildContext context) {
     return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide - Ride',
      home: CalendarPage(),
    );
  }
}
