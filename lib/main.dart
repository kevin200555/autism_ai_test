import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'video_recorder.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); // Fetch the available cameras
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VideoRecorder(camera: cameras[0],));
  } 
}

