import 'dart:io';

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:video_player/video_player.dart';

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
    await box.put('isActive', date);
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
    isActive = box.get('isActive');
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
      print(isActive);
      print(date);
      print(time);
      print(timeElasped);
      for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
        print("Recorded Video 1: ${recordedVideos?[i]?.path}");
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
    time = "${now.hour}:${now.minute}";
    saveToHive();
  }

  Future<void> getTotalVideoDuration(List<XFile?>? videos) async {
    if (videos == null) timeElasped = "0:00";

    Duration totalDuration = Duration.zero;

    for (XFile? video in videos!) {
      if (video == null) continue;

      VideoPlayerController controller = VideoPlayerController.file(
        File(video.path),
      );
      await controller.initialize(); // Load metadata
      totalDuration += controller.value.duration;
      await controller.dispose(); // Free resources
    }

    int minutes = totalDuration.inMinutes;
    int seconds = totalDuration.inSeconds % 60;

    timeElasped = "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
