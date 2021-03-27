import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_presensi_uajy/src/data/model/log_activity.dart';
import 'package:flutter_presensi_uajy/src/data/model/profile.dart';
import 'package:flutter_presensi_uajy/src/data/remote/auth_service.dart';

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

  Future<void> updateProfile(
    Profile profile,
  ) async {
    final String uid = AuthService().user.uid;
    print("update profile : ");
    print(profile.toJson());
    await _firestore
        .collection("users")
        .doc(uid)
        .update({"profile": profile.toMap()})
        .then((value) => print("updated"))
        .catchError((error) => print("ERROR : $error"));
  }

  Future<void> insertLogActivity(LogActivity logActivity) async {
    final String uid = AuthService().user.uid;

    await _firestore
        .collection("log_activities")
        .doc(uid)
        .collection("logs")
        .add(logActivity.toMap())
        .then((value) => print("log activity added"))
        .catchError((error) => print("Failed to add log activity: $error"));
  }

  Future<List<LogActivity>> getLogActivities() async {
    final String uid = AuthService().user.uid;
    List<LogActivity> data = List.empty(growable: true);

    try {
      return await _firestore
          .collection("log_activities")
          .doc(uid)
          .collection("logs")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          data.add(LogActivity.fromMap({
            "id": doc.id,
            "location": doc["location"],
            "type": doc["type"],
            "loged_at": doc["loged_at"],
          }));
        });
        return data;
      });
    } catch (e) {
      print("ERROR : $e");
    }
  }
}

// typedef OnSuccessProfile = Function(Profile profile);
