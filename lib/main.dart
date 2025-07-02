import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/information_screens/home_screen.dart';

// initizies the cameras, this is used accross all parts of the program
late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //This is NOT camerax, there may be a werid error so ensure it is not 
  //await Permission.camera.request();
  //await Permission.microphone.request();
  
  cameras = await availableCameras(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //camera is passed around through all widgets and screens in the program
    return MaterialApp(home: HomeScreen(camera: cameras[0]));
  } 
}
//EOF main.dart

//unqiue User ID
//cloud services: AWS, Oracle, Google cloud services, (HIPA complinent)