import 'dart:io';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class UserClass {
  static String? userId;
  static List<String?>? iCResponses;
  static File? signiture;
  static List<String?>? mChatRresponses;
  static List<String?>? intakeResponses;
  static List<String?>? compensationResponses;
  static List<XFile?>? recordedVideos = [null, null, null];

  static void printSummary() {
    if (kDebugMode) {
      print("User ID: $userId");
      print("Informed Consent Responses: $iCResponses");
      print("Signiture FilePath: ${signiture?.path}");
      print("mChatR Responses: $mChatRresponses");
      print("Intake Form Responses: $intakeResponses");
      print("Compensation Form Responses: $compensationResponses");

      print("Recorded Video 1: ${recordedVideos?[0]?.path}");
      print("Recorded Video 2: ${recordedVideos?[1]?.path}");
      print("Recorded Video 3: ${recordedVideos?[2]?.path}");
    }
  }

  static String generateUserReport() {
    // function that will take all responses from the the questionaires and compile them into a .txt file
    String linebreak = '===============================================\n';

    List<List<String>> intake = InstructionAndQuestions.getIntakeForm();
    String intakeString = '';
    for (int i = 0; i < intake.length; i++) {
      intakeString += "Q: ${intake[i][1]}\n";
      intakeString += "A: ${intakeResponses?[i]?[1]}\n";
    }

    List<List<String>> compensation= InstructionAndQuestions.getMChatR();
    String cString = '';
    for (int i = 0; i < compensation.length; i++) {
      cString += "Q: ${compensation[i][1]}\n";
      cString += "A: ${mChatRresponses?[i]?[1]}\n";
    }

    List<List<String>> mChatR = InstructionAndQuestions.getMChatR();
    String mString = '';
    for (int i = 0; i < mChatR.length; i++) {
      mString += "Q: ${mChatR[i][1]}\n";
      mString += "A: ${mChatRresponses?[i]?[1]}\n";
    }

    return 'User-ID: $userId\nChild-Name: ${iCResponses?[2]}\nDate: ${iCResponses?[3]}\n'
        'Parent-Name: ${iCResponses?[4]}\nRelationship-to-Participant: ${iCResponses?[5]}\n'
        'Name-of-person-who-obtained-consent: ${iCResponses?[6]}\n'
        '$linebreak $intakeString $linebreak $cString $linebreak $mString';
  }

  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/user_report.txt'); // Change filename as needed
  }

  static Future<void> writeToFile(String content) async {
    final file = await _localFile;
    await file.writeAsString(content);
  }
} // EOF user_class.dart
