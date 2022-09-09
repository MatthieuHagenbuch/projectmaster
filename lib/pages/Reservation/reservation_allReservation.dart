import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReservationDisplay extends StatefulWidget {
 
  @override
  ReservationDisplayState createState() => ReservationDisplayState();
}

class ReservationDisplayState extends State<ReservationDisplay> {
//1. Requête qui récupère les réservations qui sont stockés dans le User
//2. Requête qui récupère les champs en fonctions des id présents
  
  late List<String> idReservation;
  late final String idUser;

  
Future<void> getFavorite(uId) async {
    FirebaseFirestore.instance
        .collection("users")
        .where("uId", isEqualTo: uId)
        .get()
        .then((value) => {
           if (value != null)
           {
           // idReservation = value.docs..data()['reservation'].toList(),            
            idUser = value.docs.first.id,
           }else{
            print('Document does not exist on the database'),
           }
        });
}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }



}