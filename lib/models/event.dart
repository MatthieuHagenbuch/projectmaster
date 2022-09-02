import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? activity;
  final DateTime startEvent;

  Event({
    this.activity,
    required this.startEvent,
  });

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Event(
      activity: data?['name'],
      startEvent: data?['startEvent'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (activity != null) "activity": activity,
      "startEvent": startEvent,
    };
  }
}
