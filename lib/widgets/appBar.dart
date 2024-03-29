import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmaster/pages/Authentification/AuthGate.dart';
import 'package:projectmaster/pages/Calendar/calendar_allEvents.dart';

import 'package:projectmaster/pages/Settings/settings_details.dart';

import 'package:projectmaster/pages/Reservation/reservation_allReservation.dart';

/*
  Author : Océane - Matthieu
  
  */
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 104, 162, 207),
      centerTitle: true,
      title: Text(
        'Slide - Ride',
        style: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),

      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 1,
                child: Text('Calendar'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('All events'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 0,
                child: Text('Log out'),
              )
            ];
          },
          onSelected: (value) {
            switch (value) {
              case 0:
                signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthGate(),
                    ));
                break;

              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarDisplay(
                          FirebaseAuth.instance.currentUser?.uid),
                    ));
                break;
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllEventsDisplay(),
                    ));
                break;
              case 3:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ));
                break;
            }
          },
        )
      ],

      //actions: const [TextButton(onPressed: signOut, child: Text('Log out'))],
    );
  }
}

signOut() async {
  await FirebaseAuth.instance.signOut();
}
