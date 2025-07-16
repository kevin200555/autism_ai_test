import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadFile(String filePath) async {
  print('Uploading file: $filePath');

  final file = File(filePath);
  if (!await file.exists()) {
    print('File does not exist at path: $filePath');
    return null;
  }

  try {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('uploads/${file.uri.pathSegments.last}');

    print('Storage ref created: ${storageRef.fullPath}');

    // Provide an empty SettableMetadata to prevent null pointer errors
    final uploadTask = storageRef.putFile(file, SettableMetadata());

    print('Upload started...');
    final snapshot = await uploadTask;
    print('Upload completed');

    final downloadURL = await snapshot.ref.getDownloadURL();
    print('Download URL: $downloadURL');
    return downloadURL;
  } on FirebaseException catch (e) {
    print('FirebaseException: $e');
    return null;
  } catch (e) {
    print('Unknown error: $e');
    return null;
  }
}