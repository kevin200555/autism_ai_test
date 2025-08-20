import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_document_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// This screen is the screen that the user would see first before doing anything else on the app
// It serves as a welcome screen and purpose is to explain to the user that we need signiture first before
// continuing with the rest of the app
// welcome_screen -> ic_document -> signing and forms -> main_menu -> branches to forms, settings, video recording, etc.
class WelcomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const WelcomeScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarTitle('Welcome!', color: ColorTheme.background),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
      ),
      // Text
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubTitle('Background', textAlign: TextAlign.left),
            BodyText(
              'Getting an autism diagnosis for young children can still be slow and expensive. '
              'Many families miss the chance to get early support when it matters most.\n',
              color: ColorTheme.textColor,
            ),
            BodyText(
              'Our team at Washington University is working on a simple, low-cost tool '
              'that families can use at home to help spot early signs of autism.\n',
              color: ColorTheme.textColor,
            ),
            BodyText(
              'To make this possible, we need videos of real kids playing, interacting, and '
              'just being themselves.\n',
              color: ColorTheme.textColor,
            ),
            BodyText(
              'That\'s where you come in. By doing a few short tasks and recording them, '
              'you\'re helping us build something that could help many other families in the future.\n',
              color: ColorTheme.textColor,
            ),
            SubTitle('What are the video tasks?', textAlign: TextAlign.left),
            BodyText(
              '\t\t- ${InstructionAndQuestions.videoNames[0]}',
              color: ColorTheme.textColor,
            ),
            BodyText(
              '\t\t- ${InstructionAndQuestions.videoNames[1]}',
              color: ColorTheme.textColor,
            ),
            BodyText(
              '\t\t- ${InstructionAndQuestions.videoNames[2]}',
              color: ColorTheme.textColor,
            ),
            BodyText('', color: ColorTheme.textColor),
            BodyText(
              'We really appreciate your time and support!'
              ' These tasks are quick and simple, and your child might even think they’re just playing with you!\n',
              color: ColorTheme.textColor,
            ),
            BodyText(
              'This test will roughly take around 1-2 hours or so.  However, you are welcome to leave and come back '
              'at any time and have your progress saved.\n',
              color: ColorTheme.textColor,
            ),
            ImportantBodyText(
              'Before we begin, make sure to read and sign the form on the next page\n',
              color: ColorTheme.red,
            ),
            // transition into next page
            NextButton(
              label: 'NEXT',
              onPressed: () {
                UserClass.currentScreen = 'IC_document_form';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerScreen(camera: camera),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} // EOF welcome_screen.dart
