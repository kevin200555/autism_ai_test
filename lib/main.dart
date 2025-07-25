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
    //camera is passed around through all widgets and screens in the program
    return MaterialApp(home: HomeScreen(camera: cameras[0]));
  }
} // EOF main.dart

// Things to add:
// - progress bar (for forms) ✓
// - HiveObject to save user data if they ever leave
// - split questions into multiple pages
// - figure out text consistency ?
// - see if I can get them to split into 9 videos 
// - make the MCQ questions more cleaner (dropdown button harder to see)
// - for multiple choice questions, make it so there is like a "other option"
// - keep in mind that all types of people look at this
// - look at default text size and see if it is too small