// Author - Océane

// get data storage in firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Get data from firestore
class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ListenDataState createState() => _ListenDataState();
}

class _ListenDataState extends State<GetData> {
  // Call collection
  final Stream<QuerySnapshot> _eventsStream =
      FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    // Build flux
    return StreamBuilder<QuerySnapshot>(
      stream: _eventsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading"),
          );
        }
        // return all data storage in firestore
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> event =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(event['activity']),
              // TODo rajouter les autres données (startEvent - endEvent - course - sport - ...  )
            );
          }).toList(),
        );
      },
    );
  }
}
