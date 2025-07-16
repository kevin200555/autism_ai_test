import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadFile(String filePath) async {
  File file = File(filePath);

  try {
    // Create a reference to the location you want to upload to
    final storageRef = FirebaseStorage.instance.ref().child('uploads/${file.uri.pathSegments.last}');

    // Start upload task
    UploadTask uploadTask = storageRef.putFile(file);

    // Wait for the upload to complete
    TaskSnapshot snapshot = await uploadTask;

    // Get the download URL
    String downloadURL = await snapshot.ref.getDownloadURL();

    print('File uploaded successfully. Download URL: $downloadURL');
    return downloadURL;
  } on FirebaseException catch (e) {
    print('Upload failed: $e');
    return null;
  }
}