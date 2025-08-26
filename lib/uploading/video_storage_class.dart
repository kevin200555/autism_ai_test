import 'dart:io';

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:autism_ai_test/uploading/upload_to_firebase.dart';
import 'package:path/path.dart' as path;
import 'package:archive/archive_io.dart';

part 'video_storage_class.g.dart';

/// This class is used to store video data
/// It is used to keep track of the videos recorded by the user
/// It is also used to upload the videos to Firebase
/// It is stored in Hive for persistence
/// The videos are stored in a list of file paths
@HiveType(typeId: 1)
class VideoStorageClassItem {
  @HiveField(0)
  bool isActive;

  @HiveField(1)
  String date;

  @HiveField(2)
  String time;

  @HiveField(3)
  String timeElapsed;

  @HiveField(4)
  String score;

  /// Store **file paths** instead of raw `XFile` objects
  @HiveField(5)
  List<String?> recordedVideoPaths;

  VideoStorageClassItem({
    this.isActive = false,
    this.date = '',
    this.time = '',
    this.timeElapsed = '',
    this.score = '',
    List<String?>? recordedVideoPaths,
  }) : recordedVideoPaths =
           recordedVideoPaths ??
           List<String?>.filled(
             InstructionAndQuestions.videoNames.length,
             null,
             growable: false,
           );

  /// Convenience getter to convert back into `XFile?`
  List<XFile?> get recordedVideos =>
      recordedVideoPaths.map((p) => p != null ? XFile(p) : null).toList();

  /// Reset state
  void resetAll() {
    isActive = false;
    date = '';
    time = '';
    timeElapsed = '';
    recordedVideoPaths = List<String?>.filled(
      InstructionAndQuestions.videoNames.length,
      null,
      growable: false,
    );
  }

  /// Save whole object to Hive
  Future<void> saveToHive() async {
    final box = Hive.isBoxOpen('video_item_box')
        ? Hive.box<VideoStorageClassItem>('video_item_box')
        : await Hive.openBox<VideoStorageClassItem>('video_item_box');

    await box.put('video_item', this);
  }

  /// Load object from Hive
  static Future<VideoStorageClassItem> loadFromHive() async {
    final box = Hive.isBoxOpen('video_item_box')
        ? Hive.box<VideoStorageClassItem>('video_item_box')
        : await Hive.openBox<VideoStorageClassItem>('video_item_box');

    return box.get('video_item', defaultValue: VideoStorageClassItem())!;
  }

  /// Print a summary of the current state
  /// Useful for debugging
  void printSummary() {
    if (kDebugMode) {
      print(isActive);
      print(date);
      print(time);
      print(timeElapsed);
      for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
        print("Recorded Video $i: ${recordedVideoPaths[i]}");
      }
    }
  }

  // Start video recording
  // This should be called before the recording starts
  void startVideoRecording() {
    isActive = true;
  }

  // Stop video recording and update date/time
  // This should be called after the recording is done
  void getTime() {
    DateTime now = DateTime.now();

    // Date
    date = "${now.month}-${now.day}-${now.year}";

    // Time
    int hour = now.hour;
    int minute = now.minute;
    String period = hour >= 12 ? "PM" : "AM";

    // Convert to 12-hour format
    hour = hour % 12;
    if (hour == 0) hour = 12;

    // Add leading zero to minutes
    String minuteStr = minute.toString().padLeft(2, '0');

    time = "$hour:$minuteStr $period";
    if (kDebugMode) print("$date $time");
  }

  // Upload all recorded videos to Firebase
  // This will create a zip file of all recorded videos and upload it
  Future<void> uploadAllFiles() async {
    printSummary();
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final folder = Directory(
        path.join(appDir.path, 'videos'),
      ); // <-- correct folder

      if (!await folder.exists()) {
        if (kDebugMode) {
          print('No videos folder found!');
        }
        return;
      }

      // List all files in folder for debug 
      // loop through and print each file path
      // ignore: avoid_print
      folder.listSync().forEach((f) => print('File to zip: ${f.path}'));

      // Create zip file
      // The zip file will be created in the parent directory of the videos folder
      final zipFile = await zipFolder(folder);
      if (kDebugMode) {
        print('Created zip file: ${zipFile.path}');
      }

      // Upload zip file to Firebase
      // The uploadFile function is defined in upload_to_firebase.dart
      final url = await uploadFile(zipFile.path);
      if (url != null) {}
      if (kDebugMode) {
        {
          print('Uploaded file URL: $url');
        }
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('Error in uploadAllFiles: $e');
      }
      if (kDebugMode) {
        print(stack);
      }
    }
  }

  /// Zips the folder containing all recorded videos
  /// Returns the path to the zip file
  Future<File> zipFolder(Directory folder) async {
    final encoder = ZipFileEncoder();
    getTime();

    final zipPath = path.join(
      folder.parent.path,
      '${date.replaceAll('-', '_')}_${time.replaceAll(':', '').replaceAll(' ', '')}.zip',
    );

    encoder.create(zipPath);
    encoder.addDirectory(folder); // <-- this now points to folder with videos
    encoder.close();

    return File(zipPath);
  }
} // EOF video_storage_class.dart
