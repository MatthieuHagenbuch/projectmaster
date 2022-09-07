import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmaster/models/users.dart';

//This method add the user infos in FireStore DB if it dosen't exist alreadyq
Future<void> addUser(String? email, String? uId) async {
  var db = FirebaseFirestore.instance;

  db.collection("users").where("uId", isEqualTo: uId).get().then((value) => {
        if (value.size == 0)
          {
            db
                .collection("users")
                .add({'email': email, 'uId': uId, 'role': "user"}),
          }
      });
}
