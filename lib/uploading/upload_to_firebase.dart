import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

Future<String?> uploadFile(String filePath) async {
  if (kDebugMode) {
    print('Uploading file: $filePath');
  }
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
    final snapshot = await uploadTask;
    if (kDebugMode) {
      print('Upload completed');
    }
    final downloadURL = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print('Download URL: $downloadURL');
    }
    return downloadURL;
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
