import 'package:cloud_firestore/cloud_firestore.dart';
/*
 Author : Matthieu
 This method add the user infos in FireStore DB if it dosen't exist already
*/
Future<String> addUser(String? email, String? uId) async {
  var db = FirebaseFirestore.instance;

  String role = 'user';

  db.collection("users").where("uId", isEqualTo: uId).get().then((value) => {
        if (value.size == 0)
          {
            db
                .collection("users")
                .add({'email': email, 'uId': uId, 'role': "user"}),
          }
        else
          {
            role = value.docs.first.data()['role'].toString(),
          }
      });

  return role;
}
