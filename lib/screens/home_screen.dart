import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/themes/colors.dart';
import 'package:autism_ai_test/screens/help_screen.dart';
import 'package:autism_ai_test/data_gathering/questionaire_section.dart';
import 'package:autism_ai_test/instruction_and_questions.dart';
class HomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const HomeScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {

    var videoInstructions = InstructionAndQuestions.getVideoInstructios();
    var shortAnswerQuestions = InstructionAndQuestions.getShortAnswerQuestions();
    var multipleChoice = InstructionAndQuestions.getMultipleChoice();

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