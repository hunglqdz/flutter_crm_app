import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({
    required String name,
    required String note,
    required Uint8List file,
  }) async {
    String response = 'Some Error Occurred';
    try {
      if (name.isNotEmpty || note.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('itemImage', file);
        await _firestore.collection('item').add({
          'name': name,
          'note': note,
          'imageLink': imageUrl,
        });
        response = 'success';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
