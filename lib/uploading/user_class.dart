import 'dart:io';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/upload_to_firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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

  Future<void> saveFilesToMasterFolder(File userReport, List<File?> recordedVideos, String userId) async {
  final directory = await getApplicationDocumentsDirectory();
  final folder = Directory(path.join(directory.path, userId));

  if (!(await folder.exists())) {
    await folder.create(recursive: true);
  }

  // Copy user report
  final userReportDest = File(path.join(folder.path, path.basename(userReport.path)));
  await userReport.copy(userReportDest.path);

  // Copy each recorded video (assuming you have 3 and they're not null)
  for (int i = 0; i < recordedVideos.length; i++) {
    final video = recordedVideos[i];
    if (video != null) {
      final dest = File(path.join(folder.path, path.basename(video.path)));
      await video.copy(dest.path);
    }
  }
  
  final url = await uploadFile(folder.path);
      if (url != null) {
        if (kDebugMode){
          print('Uploaded file URL: $url');
        }
        // You can now use this URL to display the file or save it in your database
      }
  if (kDebugMode){
    print('Saved files to ${folder.path}');
  }
}
} // EOF user_class.dart
