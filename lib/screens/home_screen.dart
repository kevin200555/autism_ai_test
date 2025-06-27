import 'package:auto_size_text/auto_size_text.dart';
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
    //Edit this list to display different instructions to the user, these are used in the video_recording_section
    var videoInstructions = [
      'I just want to see about how long I could make this one instruction until it starts to look a little werid'
          'I think that it should be fine since there\'s no way one instruction could possibly be too long but I think'
          'it is good to know the limits of this.  More text, More text, More text, More text, More text,More text, More text, More text,More text,'
          'More text, More text, More text, More text, More text, More text,More text, More text,',
      '1. Read this line of instruction out loud\n 2. Jump up and down\n3. Wave to the camera\n4. Clap your hands together',
      'Smile :)',
    ];

    //Edit this list to change the questions for the short answers
    var shortAnswerQuestions = [
      'What is your favorite color?',
      'How are you doing today?',
      'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really Really Really'
          'Really Really Really Really Really Really Really Really long question?',
    ];
    //Edit this list to change the questions and answers for the multipleChoice
    //question is the first list item, answers are the rest of the items
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              'Ready to begin?',
              style: TextStyle(fontSize: 18, color: ColorTheme.alternateTextColor),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            //The Start button, starts the test
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 150,
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
                child: AutoSizeText(
                  'START',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.textColor,
                  ),
                  maxLines: 1,
                  minFontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.2),
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