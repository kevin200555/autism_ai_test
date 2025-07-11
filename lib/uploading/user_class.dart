import 'dart:io';

import 'package:camera/camera.dart';

class UserClass {
   static String? userId;
   static List<String?>? iCResponses;
   static File? signiture;
   static List<String?>? mChatRresponses;
   static List<String?>? intakeResponses;
   static List<XFile?>? recordedVideos;

  static void printSummary(){
    print("User ID: $userId");
    print("Informed Consent Responses: $iCResponses");
    print("Signiture FilePath: ${signiture?.path}");
    print("mChatR Responses: $mChatRresponses");
    print("Intake Form Responses: $intakeResponses");
  }
} // EOF user
