import 'package:autism_ai_test/screens/help_screen.dart';
import 'package:autism_ai_test/data_gathering/video_recording_section.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class HomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const HomeScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {
    //Use this variable to display different instructions to the user
    var givenInstructionsToUser = [
    'Take a video of yourself seeing how many lines of text could this widget support before it starts to look a bit too weird.',
    '1. Read this line of instruction out loud\n 2. Jump up and down\n3. Wave to the camera\n4. Clap your hands together',
    'Scale of the Dragon\nTwin Metours\nRecoil',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Autism Test',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // Set desired width
              height: 200, // Set desired height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuidedVideoRecording(
                        camera: camera,
                        instructions: givenInstructionsToUser,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20), // space inside the button
                  backgroundColor: const Color.fromARGB(255, 1, 51, 93),
                ),
                child: const Text(
                  'START',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpScreen(),
                    ),
                  );
                },
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
        foregroundColor: Colors.white,
        child: const Icon(Icons.question_mark),
      ),
    );
  }
}
