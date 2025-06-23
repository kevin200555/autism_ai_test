import 'package:autism_ai_test/data_gathering/questionaire_section.dart';
import 'package:autism_ai_test/screens/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class HomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const HomeScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {
    //Use this list to display different instructions to the user, these are used in the video_recording_section
    var videoInstructions = [
      'Take a video of yourself seeing how many lines of text could this widget support before it starts to look a bit too weird.',
      '1. Read this line of instruction out loud\n 2. Jump up and down\n3. Wave to the camera\n4. Clap your hands together',
      'Scale of the Dragon\nTwin Metours\nRecoil',
    ];
    //Change this list with survey monkey urls to display different web surveys
    var surveyURLs = ['https://www.surveymonkey.com/r/LT6DG35'];

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          'The Autism Test',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //The Start button, starts the test
            SizedBox(
              width: 200, 
              height: 200, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GuidedQuestionaire(urls: surveyURLs, camera: camera, instructions: videoInstructions,),
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
      //Displays a help menu 
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 95, 230, 64),
        foregroundColor: Colors.white,
        child: const Icon(Icons.question_mark),
      ),
    );
  }
}
//EOF home_screen.dart