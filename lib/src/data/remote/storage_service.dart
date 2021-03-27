import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(
    String filePath,
    String ref,
  ) async {
    final File file = File(filePath);
    UploadTask task = _firebaseStorage.ref(ref).putFile(file);
    String url;

    task.snapshotEvents.listen((event) {
      print("STATE : ${event.state}");
      print("Progress: ${(event.bytesTransferred / event.totalBytes) * 100} %");
    }, onError: (e) {
      print(task.snapshot);
    });

    try {
      await task.whenComplete(
          () async => url = await _firebaseStorage.ref(ref).getDownloadURL());
      return url;
    } on FirebaseException catch (e) {
      print("ERROR : ${e}");
    }
  }
}
