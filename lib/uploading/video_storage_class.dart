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

class VideoStorageClassItem {
  static bool isActive = false;
  static String date = '';
  static String time = '';
  static String timeElasped = '';
  // These store the videos (size of these could change later)
  static List<XFile?>? recordedVideos = List<XFile?>.filled(
    InstructionAndQuestions.videoNames.length,
    null,
    growable: false,
  );

  static resetAll() {
    isActive = false;
    date = '';
    time = '';
    timeElasped = '';
    recordedVideos = List<XFile?>.filled(
      InstructionAndQuestions.videoNames.length,
      null,
      growable: false,
    );
    saveToHive();
  }

  static Future<void> saveToHive() async {
    final box = await Hive.openBox('user_data');
    await box.put('isActive', isActive);
    await box.put('date', date);
    await box.put('time', time);
    await box.put('timeElasped', timeElasped);
    // Save recorded video paths
    List<String?> videoPaths = recordedVideos!
        .map((file) => file?.path)
        .toList();
    await box.put('recordedVideoPaths', videoPaths);
  }

  static Future<void> loadFromHive() async {
    final box = await Hive.openBox('user_data');
    // Uncomment to wipe old data for testing
    // await box.clear();
    isActive = box.get('isActive', defaultValue: false);
    date = box.get('date', defaultValue: '');
    time = box.get('time', defaultValue: '');
    timeElasped = box.get('timeElasped', defaultValue: '');
    final videoPaths = (box.get('recordedVideoPaths') as List?)
        ?.cast<String?>();
    if (videoPaths != null) {
      recordedVideos = videoPaths
          .map((p) => p != null ? XFile(p) : null)
          .toList();
    }
    printSummary();
  }

  // prints all relevant variables in the UserClass
  static void printSummary() {
    if (kDebugMode) {
      print(isActive);
      print(date);
      print(time);
      print(timeElasped);
      for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
        print("Recorded Video $i: ${recordedVideos?[i]?.path}");
      }
    }
  }

  static void startVideoRecording() {
    isActive = true;
    saveToHive();
  }

  static void getStartTime() {
    DateTime now = DateTime.now();
    date = "${now.month}-${now.day}-${now.year}";
    time = (now.hour >= 12)
        ? "${now.hour - 12}:${now.minute} PM"
        : "${now.hour}:${now.minute} AM";
    saveToHive();
  }

  static Future<void> uploadAllFiles(File userReport) async {
    printSummary();
    try {
      // Get app documents directory
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory(path.join(directory.path, UserClass.userId));

      // Ensure folder exists
      if (!await folder.exists()) {
        await folder.create(recursive: true);
        if (kDebugMode) {
          print('Created folder: ${folder.path}');
        }
      }

      // Copy each recorded video
      for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
        final video = recordedVideos?[i];
        if (video != null) {
          final file = File(video.path);
          if (await file.exists()) {
            final dest = File(
              path.join(
                folder.path,
                '${InstructionAndQuestions.videoNames[i]}.mp4',
              ),
            );
            await file.copy(dest.path);
            if (kDebugMode) {
              print('Copied video to: ${dest.path}');
            }
          } else {
            if (kDebugMode) {
              print('Video file missing, skipping: ${video.path}');
            }
          }
        } else {
          if (kDebugMode) {
            print('Recorded video is null for index $i, skipping');
          }
        }
      }

      // Zip the folder
      final zipFile = await zipFolder(folder);
      if (kDebugMode) print('Created zip file: ${zipFile.path}');

      // Upload zip
      final url = await uploadFile(zipFile.path);
      if (url != null && kDebugMode) {
        if (kDebugMode) {
          print('Uploaded file URL: $url');
        }
      }

      if (kDebugMode) {
        print('Finished saving files to: ${folder.path}');
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('Error in uploadAllFiles: $e');
        print(stack);
      }
    }
  }

  static Future<File> zipFolder(Directory folder) async {
    final encoder = ZipFileEncoder();
    if (kDebugMode) {
      print(time);
      print(date);
    }

    //file name should look like 8_20_2025_11:57AM.zip
    final zipPath = path.join(
      folder.parent.path,
      '${date.replaceAll('-', '_')}_${time.replaceAll('-', '').replaceAll(' ', '')}.zip',
    );
    encoder.create(zipPath);
    encoder.addDirectory(folder);
    encoder.close();
    return File(zipPath);
  }
}
