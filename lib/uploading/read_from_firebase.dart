import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'dart:typed_data';

//This function reads a text file from firebase, it will probably be used to display the results to the user
Future<String> readTextFileFromFirebase(String path) async {
  try {
    final ref = FirebaseStorage.instance.ref(path);
    Uint8List? data = await ref.getData(); // null if fails
    if (data != null) {
      return utf8.decode(data);
    } else {
      throw Exception("No data found");
    }
  } catch (e) {
    throw Exception("Failed to read file: $e");
  }
}
