import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectmaster/Authentication/AuthGate.dart';
import 'firebase_options.dart';
import 'package:projectmaster/pages/calendar_main.dart';

//Method DevMatt
/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

//Metehod DevOce
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
      //home: CalendarPage(),
      home: AuthGate(),
    );
  }
}
