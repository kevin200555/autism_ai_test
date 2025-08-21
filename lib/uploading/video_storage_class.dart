import 'dart:io';

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
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
    date = "${now.month}-${now.day}-${now.year}";
    time = (now.hour >= 12)
        ? "${now.hour - 12}:${now.minute} PM"
        : "${now.hour}:${now.minute} AM";
  }

  Future<void> uploadAllFiles() async {
    printSummary();
    try {
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory(path.join(directory.path, UserClass.userId));

      if (!await folder.exists()) {
        await folder.create(recursive: true);
        if (kDebugMode) print('Created folder: ${folder.path}');
      }

      for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
        final videoPath = recordedVideoPaths[i];
        if (videoPath != null) {
          final file = File(videoPath);
          if (await file.exists()) {
            final dest = File(
              path.join(
                folder.path,
                '${InstructionAndQuestions.videoNames[i]}.mp4',
              ),
            );
            await file.copy(dest.path);
            if (kDebugMode) print('Copied video to: ${dest.path}');
          } else {
            if (kDebugMode) print('Video file missing: $videoPath');
          }
        }
      }

      final zipFile = await zipFolder(folder);
      if (kDebugMode) print('Created zip file: ${zipFile.path}');

      final url = await uploadFile(zipFile.path);
      // ignore: avoid_print
      if (url != null && kDebugMode) print('Uploaded file URL: $url');

      if (kDebugMode) print('Finished saving files to: ${folder.path}');
    } catch (e, stack) {
      if (kDebugMode) {
        print('Error in uploadAllFiles: $e');
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
      '${date.replaceAll('-', '_')}_${time.replaceAll('-', '').replaceAll(' ', '')}.zip',
    );
    encoder.create(zipPath);
    encoder.addDirectory(folder);
    encoder.close();
    return File(zipPath);
  }
} // EOF video_storage_class.dart
