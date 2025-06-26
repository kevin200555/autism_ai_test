import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/themes/colors.dart';
import 'package:autism_ai_test/screens/help_screen.dart';
import 'package:autism_ai_test/data_gathering/questionaire_section.dart';

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
      'Smile :)',
    ];

    //Change this list with survey monkey urls to display different web surveys
    var shortAnswerQuestions = [
      'What is your favorite color?',
      'How are you doing today?',
      'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really long question?',
    ];
    var multipleChoice = [
      ['How are you?', 'good', 'ok', 'bad'],
      ['Chicken or Beef?', 'chicken', 'beef'],
      [
        'What is your favorite color',
        'Red',
        'Orange',
        'Yellow',
        'Green',
        'Blue',
        'Purple',
        'Black',
        'White',
        'Brown',
        'Grey',
      ],
    ];

    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'The Autism Test',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorTheme.textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to The Autism Test',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'Ready to begin?',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height:200),
            //The Start button, starts the test
            SizedBox(
              width: 200,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuidedQuestionaire(
                        camera: camera,
                        shortAnswerInstructions: shortAnswerQuestions,
                        videoInstructions: videoInstructions,
                        multipleChoice: multipleChoice,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 10,
                  backgroundColor: ColorTheme.accent,
                  shadowColor: const Color.fromARGB(105, 155, 39, 176),
                ),
                child: Text(
                  'START',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height:300),

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
        backgroundColor: ColorTheme.accent,
        foregroundColor: ColorTheme.textColor,
        child: const Icon(Icons.question_mark),
      ),
    );
  }
}
//EOF home_screen.dart