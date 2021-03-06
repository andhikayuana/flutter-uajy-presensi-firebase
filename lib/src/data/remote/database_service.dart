import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  Future<Profile> getProfile(String id) async {
    print("getProfile");
    try {
      return await _firestore
          .collection("users")
          .doc(id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data();
          final profile = Profile.fromMap(data["profile"]);
          return profile;
        }
      });
    } catch (e) {
      print(e);
    }
  }
}

// typedef OnSuccessProfile = Function(Profile profile);
