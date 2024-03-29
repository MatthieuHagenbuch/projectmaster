import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:projectmaster/pages/Authentification/addUser.dart';
import 'package:projectmaster/pages/Calendar/calendar_allEvents.dart';

/*
 Author : Matthieu
 Login management
*/
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: AspectRatio(
                    aspectRatio: 0.1,
                    child: Image.asset('assets/icons/icon_transparent.png'),
                  ),
                );
              },
              providerConfigs: const [
                EmailProviderConfiguration(),
              ]);
        }

        //Add user data in Firebase
        addUser(FirebaseAuth.instance.currentUser?.email,
            FirebaseAuth.instance.currentUser?.uid);

        // Render the application if authenticated
        return CalendarDisplay(FirebaseAuth.instance.currentUser?.uid);
      },
    );
  }
}
