import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/compensation_form.dart';
import 'package:autism_ai_test/screens/data_gathering/ic_document_form.dart';
import 'package:autism_ai_test/screens/data_gathering/ic_signiture.dart';
import 'package:autism_ai_test/screens/data_gathering/intake_form_screen.dart';
import 'package:autism_ai_test/screens/data_gathering/m_chatr_form_screen.dart';
import 'package:autism_ai_test/screens/data_gathering/video_recording_section_screen.dart';
import 'package:autism_ai_test/screens/information_screens/video_section_info_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/information_screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';

// initizies the cameras, this is used accross all parts of the program
late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This is NOT camerax, there may be a werid error so ensure it is not
  // await Permission.camera.request();
  // await Permission.microphone.request();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await UserClass.loadFromHive();
  cameras = await availableCameras();
  runApp(AutismAITest());
}

class AutismAITest extends StatelessWidget {
  const AutismAITest({super.key});

  @override
  Widget build(BuildContext context) {
    Widget initialScreen;
    // ScreenNumber and the screen
    // 0 : Homescreen
    // N/A : IC document
    // 1 : Informed Consent form screen
    // 2 : Infomred Conset Signiture Screen
    // ===================================
    // 3 : Intake Form - Child
    // 4 : Intake Form - Parent
    // 5 : Compensation Form
    // ===================================
    // 6 : MChatR Form 1
    // 7 : MChatR Form 2 (direct to MChatR Form 1)
    // ===================================
    // 8 : Video Section Information
    // 9 : Video Section Information
    // 10 : Video Section Information
    // 11 : Video Section Information
    // ===================================
    // 12 : Video Test 1
    // 13 : Video Test 2
    // 14 : Video Test 3
    switch (UserClass.screenNumber) {
      case 1:
        initialScreen = InformedConsentSigningScreen(camera: cameras[0]);
      case 2:
        initialScreen = InformedConsentSignitureScreen(camera: cameras[0]);
      case 3:
        initialScreen = ChildIntakeFormScreen(camera: cameras[0]);
      case 4:
        initialScreen = ParentIntakeFormScreen(camera: cameras[0]);
      case 5:
        initialScreen = CompensationFormScreen(camera: cameras[0]);
      case 6:
        initialScreen = MChatRFormScreen1(camera: cameras[0]);
      case 7:
        initialScreen = MChatRFormScreen2(
          camera: cameras[0],
          responses: UserClass.mChatRresponses ?? <String?>[],
        );
      case 8:
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 9:
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 10:
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 11:
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 12:
        initialScreen = VideoRecordingSectionScreen(
          camera: cameras[0],
          instructions: InstructionAndQuestions.getVideoInstructios(),
          currentStep: 0,
        );
      case 13:
        initialScreen = VideoRecordingSectionScreen(
          camera: cameras[0],
          instructions: InstructionAndQuestions.getVideoInstructios(),
          currentStep: 1,
        );
      case 14:
        initialScreen = VideoRecordingSectionScreen(
          camera: cameras[0],
          instructions: InstructionAndQuestions.getVideoInstructios(),
          currentStep: 2,
        );
      default:
        initialScreen = HomeScreen(camera: cameras[0]);
    }
    //camera is passed around through all widgets and screens in the program
    return MaterialApp(home: initialScreen, debugShowCheckedModeBanner: false);
  }
} // EOF main.dart

// Things to add:
// - progress bar (for forms) ✓
// - HiveObject to save user data if they ever leave ✓
// - split questions into multiple pages ✓
// - figure out text consistency ?
// - update help menu ✓
// - with a restart button 
// - and maybe multiple screens 
// Things to note:
// - see if I can get them to split into 9 videos 
// - make the MCQ questions more cleaner (dropdown button harder to see)
// - for multiple choice questions, make it so there is like a "other option"
// - keep in mind that all types of people look at this
// - look at default text size and see if it is too small