import 'package:autism_ai_test/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'video_recorder.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(camera: cameras[0]));
  } 
}

