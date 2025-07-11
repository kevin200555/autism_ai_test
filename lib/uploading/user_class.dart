import 'dart:io';

import 'package:camera/camera.dart';

class UserClass {
  static String? userId;
  static List<String?>? iCResponses;
  static File? signiture;
  static List<String?>? mChatRresponses;
  static List<String?>? intakeResponses;
  static List<XFile?>? recordedVideos = [null,null,null];

  static void printSummary() {
    print("User ID: $userId");
    print("Informed Consent Responses: $iCResponses");
    print("Signiture FilePath: ${signiture?.path}");
    print("mChatR Responses: $mChatRresponses");
    print("Intake Form Responses: $intakeResponses");

    print("Recorded Video 1: ${recordedVideos?[0]?.path}");
    print("Recorded Video 2: ${recordedVideos?[1]?.path}");
    print("Recorded Video 3: ${recordedVideos?[2]?.path}");
  }
} // EOF user
