import 'package:autism_ai_test/screens/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'data_gathering/video_recording_section.dart';

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

