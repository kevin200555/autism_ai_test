import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
// The purpose of this module is to upload the data to firebase
// The data is first compressed into a zip file, found by this module,
// and then uploaded to firebase
// It is important to note that I made it so that only the admin can read the data, anyone else cannot
Future<String?> uploadFile(String filePath) async {
  
  if (kDebugMode) {
    print('Uploading file: $filePath');
  }
  // find the filePath that is attempting to be uploaded
  final file = File(filePath);
  if (!await file.exists()) {
    if (kDebugMode) {
      print('File does not exist at path: $filePath');
    }
    return null;
  }

  try {
    final storageRef = FirebaseStorage.instance.ref().child(
      'uploads/${file.uri.pathSegments.last}',
    );
    if (kDebugMode) {
      print('Storage ref created: ${storageRef.fullPath}');
    }
    // Provide an empty SettableMetadata to prevent null pointer errors
    final uploadTask = storageRef.putFile(file, SettableMetadata());
    if (kDebugMode) {
      print('Upload started...');
    }
    // ignore: unused_local_variable
    final snapshot = await uploadTask;
    if (kDebugMode) {
      print('Upload completed');
    }
    return null;

  } on FirebaseException catch (e) {
    if (kDebugMode) {
      print('FirebaseException: $e');
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      print('Unknown error: $e');
    }
    return null;
  }
} // EOF upload_to_firebase.dart
