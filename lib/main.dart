
import 'package:autism_ai_test/screens/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //This is NOT camerax, there may be a werid error so ensure it is not 
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

