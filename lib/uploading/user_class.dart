import 'dart:io';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/upload_to_firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:archive/archive_io.dart';
import 'package:hive/hive.dart';

// Class that stores information about the User
// May want to use HiveObject in order to save the information if the user disconnects
class UserClass {
  static String? userId;
  static int screenNumber = 0;
  static int totalScreenNumber = 13;
  static List<String?>? iCResponses;
  static File? signiture;
  static List<String?>? mChatRresponses;
  static List<String?>? intakeResponses;
  static List<String?>? compensationResponses;
  static List<XFile?>? recordedVideos = [null, null, null];

  static Future<void> saveToHive() async {
    final box = await Hive.openBox('user_data');
    await box.put('userId', userId);
    await box.put('screenNumber', screenNumber);
    await box.put('iCResponses', iCResponses);
    await box.put('mChatRresponses', mChatRresponses);
    await box.put('intakeResponses', intakeResponses);
    await box.put('compensationResponses', compensationResponses);
    await box.put('signiturePath', signiture?.path);

    // Save recorded video paths
    List<String?> videoPaths = recordedVideos!
        .map((file) => file?.path)
        .toList();
    await box.put('recordedVideoPaths', videoPaths);
  }

  static Future<void> loadFromHive() async {
    final box = await Hive.openBox('user_data');
    userId = box.get('userId');
    screenNumber = box.get('screenNumber') ?? 0;
    iCResponses = (box.get('iCResponses') as List?)?.cast<String?>();
    mChatRresponses = (box.get('mChatRresponses') as List?)?.cast<String?>();
    intakeResponses = (box.get('intakeResponses') as List?)?.cast<String?>();
    compensationResponses = (box.get('compensationResponses') as List?)
        ?.cast<String?>();

    final signPath = box.get('signiturePath');
    if (signPath != null) {
      signiture = File(signPath);
    }

    final videoPaths = (box.get('recordedVideoPaths') as List?)
        ?.cast<String?>();
    if (videoPaths != null) {
      recordedVideos = videoPaths
          .map((p) => p != null ? XFile(p) : null)
          .toList();
    }
    printSummary();
  }

  static void printSummary() {
    if (kDebugMode) {
      print("User ID: $userId");
      print("Informed Consent Responses: $iCResponses");
      print("Signiture FilePath: ${signiture?.path}");
      print("mChatR Responses: $mChatRresponses");
      print("Intake Form Responses: $intakeResponses");
      print("Compensation Form Responses: $compensationResponses");
      print("Screen Number:  $screenNumber");

      print("Recorded Video 1: ${recordedVideos?[0]?.path}");
      print("Recorded Video 2: ${recordedVideos?[1]?.path}");
      print("Recorded Video 3: ${recordedVideos?[2]?.path}");
    }
  }

  // function that will take all responses from the the questionaires and turn them into a string,
  // this string will then be written to a file
  static String generateUserReport() {
    String linebreak = '===============================================\n';

    List<List<String>> intake = InstructionAndQuestions.getIntakeForm();
    String intakeString = '';
    for (int i = 0; i < intake.length; i++) {
      intakeString += "Q: ${intake[i][1]}\n";
      intakeString += "A: ${intakeResponses?[i]?[1]}\n";
    }

    List<List<String>> compensation = InstructionAndQuestions.getMChatR();
    String cString = '';
    for (int i = 0; i < compensation.length; i++) {
      if (compensation[i][1] == 'Social Security Number: ') {
        cString += "Q: ${compensation[i][1]}\n";
        cString += "Q: ###-###-####";
      } else {
        cString += "Q: ${compensation[i][1]}\n";
        cString += "A: ${mChatRresponses?[i]?[1]}\n";
      }
    }

    List<List<String>> mChatR = InstructionAndQuestions.getMChatR();
    String mString = '';
    for (int i = 0; i < mChatR.length; i++) {
      mString += "Q: ${mChatR[i][1]}\n";
      mString += "A: ${mChatRresponses?[i]?[1]}\n";
    }

    return 'User-ID: $userId\n$linebreak Child-Name: ${iCResponses?[2]}\nDate: ${iCResponses?[3]}\n'
        'Parent-Name: ${iCResponses?[4]}\nRelationship-to-Participant: ${iCResponses?[5]}\n'
        'Name-of-person-who-obtained-consent: ${iCResponses?[6]}\n'
        '$linebreak $intakeString $linebreak $cString $linebreak $mString';
  }

  // makes the user_report.txt file
  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/${userId}_user_report.txt');
  }

  // writes to user_report.txt file
  static Future<File> writeToReportFile(String content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  static Future<void> uploadAllFiles(File userReport) async {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory(path.join(directory.path, userId));

    if (!(await folder.exists())) {
      await folder.create(recursive: true);
    }

    // Copy user report
    final userReportDest = File(
      path.join(folder.path, path.basename(userReport.path)),
    );
    await userReport.copy(userReportDest.path);

    // Copy each recorded video (assuming you have 3 and they're not null)
    for (int i = 0; i < 3; i++) {
      final video = recordedVideos?[i];
      if (video != null) {
        final file = File(video.path);
        final dest = File(path.join(folder.path, path.basename(video.path)));
        await file.copy(dest.path);
      }
    }

    File? imageFile = File(signiture!.path);
    final imageDest = File(
      path.join(folder.path, path.basename(imageFile.path)),
    );
    await imageFile.copy(imageDest.path);

    final zipFile = await zipFolder(folder);
    final url = await uploadFile(zipFile.path);

    if (url != null) {
      if (kDebugMode) {
        print('Uploaded file URL: $url');
      }
      // You can now use this URL to display the file or save it in your database
    }
    if (kDebugMode) {
      print('Saved files to ${folder.path}');
    }
  }

  //zips folder
  static Future<File> zipFolder(Directory folder) async {
    final encoder = ZipFileEncoder();
    final zipPath = path.join(
      folder.parent.path,
      '${path.basename(folder.path)}.zip',
    );
    encoder.create(zipPath);
    encoder.addDirectory(folder);
    encoder.close();
    return File(zipPath);
  }
} // EOF user_class.dart
