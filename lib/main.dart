import 'package:autism_ai_test/screens/main_menu/home_menu_screen.dart';
import 'package:autism_ai_test/screens/video_section/video_recording_menu.dart';
import 'package:autism_ai_test/screens/other/no_camera_error_screen.dart';
import 'package:autism_ai_test/screens/intake/compensation_form.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_document_form.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_signiture.dart';
import 'package:autism_ai_test/screens/intake/intake_form_screen.dart';
import 'package:autism_ai_test/screens/mchatr/m_chatr_form_screen.dart';
import 'package:autism_ai_test/screens/video_section/video_section_info_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/information_screens/home_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/services.dart';

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
  try {
    cameras = await availableCameras();
  } catch (e) {
    if (kDebugMode) {
      print('Error getting cameras: $e');
    }
    cameras = []; // ensure it's at least an empty list
  }
  // sets the screen orientation to be vertical (things don't really look right when in horizontal)
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(AutismAITest());
}

class AutismAITest extends StatelessWidget {
  const AutismAITest({super.key});

  @override
  Widget build(BuildContext context) {
    // checks to make sure the device has a camera
    // I doubt this will be an issue but it's worth catching
    if (cameras.isEmpty) {
      if (kDebugMode) {
        print('yeah so ur camera doesn\'t exist?');
        return NoCameraErrorScreen();
      }
    }
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
    // 12 : Video Menu
    // 13 : Video Menu
    // 14 : Video Menu
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
      // anytime the user disconnects from the General Instructions Screen, it brings the User to the first screen in that area
      // This is because their isn't a reason not to, might as well since you're not filling anything out any information
      case 8:
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 9:
        UserClass.screenNumber = 8;
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 10:
        UserClass.screenNumber = 8;
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 11:
        UserClass.screenNumber = 8;
        initialScreen = GeneralInstructionsScreen(camera: cameras[0]);
      case 12:
        initialScreen = VideoRecordingMenu(camera: cameras[0]);
      case 13:
        initialScreen = VideoRecordingMenu(camera: cameras[0]);
      case 14:
        initialScreen = VideoRecordingMenu(camera: cameras[0]);
      default:
        UserClass.screenNumber = 0;
        initialScreen = HomeScreen(camera: cameras[0]);
    }
    //camera is passed around through all widgets and screens in the program
    return MaterialApp(home: HomeMenuScreen(camera: cameras[0]), debugShowCheckedModeBanner: false);
  }
} // EOF main.dart

// Things to add:
// - progress bar (for forms) ✓
// - HiveObject to save user data if they ever leave ✓
// - split questions into multiple pages ✓
// - figure out text consistency ✓
// - update help menu ✓
// - with a restart button ✓
// - and maybe multiple screens 
// - have a menu where the user can choose which video to do first ✓
// - be it a drop down menu or like a scrollable menu or what have you ✓
// - menu where the user can continously upload videos of their child to check for susipoious behaviors
// - see if I can read data from firebase / google cloud services ✓
//   and display it on the app
// Things to note:
// - see if I can get them to split into 9 videos 
// - make the MCQ questions more cleaner (dropdown button harder to see) ✓
// - for multiple choice questions, make it so there is like a "other option" 
// - keep in mind that all types of people look at this
// - look at default text size and see if it is too small
//
// =========================================================================================
//
// meeting notes:
// - Free play is a generalist video recording
// - uses google gemini, based on everyone's behavior, a large language model
// - looks at behaviors from many different instances to diaganois
// - probably best to drop the user off after the IC document
// - The model doesn't have test/train data
// - John Constantine
// - eye tracking for autism research
// - https://www.thetransmitter.org/spectrum/new-tablet-based-tools-
//   to-spot-autism-draw-excitement-and-questions/
// - Cognoa (similar model) - providing diagnois or for referral
// - all schools provide ABA, it is whether or not they want to give it or not
// - aba is covered by insurance
// - can we help in rural communities and family doctors?
// - app can provide evidence to schools for an evulations
// - like a $100 doctor appointment checkup for covid is worse than like a covid test kit
// - check ins with the app every year, every month, etc. could charge for each one or
//   something
// - echo system?
// Value:
// - actual diaganosis (very hard)
// - some sort of scale (like 90% chance of autism)
// - target for families
// - family reassurance
// - highlight behavior
// - 
// - family take video, we give a score, this makes it so that they skip the primary doctor
//   and the wait times
// - can we give referrals? 
// - subscription based model or some package deal things
// - compares to "normal" behaviors
// - perhaps an autism tracker as opposed to an autism test

//Given this, I think I got an idea how to organize the app
//At the beginning, I make the user take the IC document 
//This gets thier user id 
//After this, bring them to a page to pay for our services
//After paying, bring them to the "main menu"
//main menu has a home screen -> forms screen <-> a videos screen, previous results screen, and settings screen
//Make them take the intake/mChatR form first (lock the videos)
//after this, they are able to do the video 
//Here they can take videos and upload them and get their results back, these can later be seen on the previous results screen  
//We could remind them to do this every ____ months or so
