import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event.dart';

Future<void> getData() async {
  var db = FirebaseFirestore.instance;

  db.collection("events").get().then(
        (res) => print("Successfully completed"),
        onError: (e) => print("Error completing: $e"),
      );

/*final ref = db.collection("events").doc().withConverter(
      fromFirestore: Event.fromFirestore,
      toFirestore: (Event event, _) => Event.toFirestore(),
    );
final docSnap = await ref.get();
final event = docSnap.data(); // Convert to City object
if (event != null) {
  print(event);
} else {
  print("No such document.");
}*/
}
