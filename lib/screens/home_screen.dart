import 'package:autism_ai_test/data_gathering/questionaire_section.dart';
import 'package:autism_ai_test/screens/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/themes/colors.dart';
class HomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const HomeScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {
    //Use this list to display different instructions to the user, these are used in the video_recording_section
    var videoInstructions = [
      'I just want to see about how long I could make this one instruction until it starts to look a little werid'
      'I think that it should be fine since there\'s no way one instruction could possibly be too long but I think'
      'it is good to know the limits of this',
      '1. Read this line of instruction out loud\n 2. Jump up and down\n3. Wave to the camera\n4. Clap your hands together',
      'Scale of the Dragon\nTwin Metours\nRecoil\nWORLD CUTTING SLASH',
    ];

    //Change this list with survey monkey urls to display different web surveys
    var surveyURLs = ['https://www.surveymonkey.com/r/LT6DG35',
    'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4',
    'https://eecs.uci.edu/~liky4/'];

    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'The Autism Test',
          style: TextStyle(fontWeight: FontWeight.bold, color: ColorTheme.textColor),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.primary,
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
                  backgroundColor: ColorTheme.primary,
                ),
                child: Text(
                  'START',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //Displays a help menu 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpScreen()),
          );
        },
        backgroundColor: ColorTheme.primary,
        foregroundColor: ColorTheme.textColor,
        child: const Icon(Icons.question_mark),
      ),
    );
  }
}
//EOF home_screen.dart