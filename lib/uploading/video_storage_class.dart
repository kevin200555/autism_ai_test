import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class VideoStorageClassItem {
  static String date = '';
  static String time = '';
  static int timeElasped = 0;
  // These store the videos (size of these could change later)
  static List<XFile?>? recordedVideos = List<XFile?>.filled(
    InstructionAndQuestions.videoNames.length,
    null,
    growable: false,
  );

  static Future<void> saveToHive() async {
    final box = await Hive.openBox('user_data');
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
    date = box.get('date');
    time = box.get('time');
    timeElasped = box.get('timeElasped');
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
      print(date);
      print(time);
      print(timeElasped);
      for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
        print("Recorded Video 1: ${recordedVideos?[i]?.path}");
      }
    }
  }

  static void getTime() {
    DateTime now = DateTime.now();
    date = "${now.month}-${now.day}-${now.year}";
    time = "${now.hour}:${now.minute}";
    saveToHive();
  }
}
