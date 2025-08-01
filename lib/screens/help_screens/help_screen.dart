import 'package:autism_ai_test/widgets/button/reset_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/constants/colors.dart';

// purpose of this widget is to display some information to the user about the app and how it works
// Accessed through the pressing of the help button present on most pages in the top right corner
class HelpScreen extends StatelessWidget {
  final CameraDescription camera;
  const HelpScreen({super.key, required this.camera});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'HELP MENU',
          color: ColorTheme.textColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
      ),
      // all of the text information
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Getting started section
            SubTitle('Getting Started / How to Use'),
            BodyText(
              'Welcome to the Autism AI Test app, this menu will give you a step-by-step guide '
              'to using this app to its fullest capabilities. \n\n'
              'This test consists of an Informed Consent Document, Autism Intake Information Form, '
              'M-ChatR Form, and Recorded Video Section. The first three are just forms that you must fill out. '
              'These forms consist of some multiple choice questions and short answer questions\n\n'
              'The Recorded Video Section requires that you follow the instructions listed to '
              'record a successful video. \n\n'
              'Keep in mind that this app will ask you to use your camera; you\'ll need to accept '
              'this request to record.',
              maxLines: 15,
            ),
            // FAQ Section
            SubTitle('FAQ'),
            BodyText(
              'Q: Does my progress save?\n'
              'A: Yes! You are welcome to leave the app at any time and come back to your saved progress. '
              'you\'re encourgaed to do this; especially if your child needs a break. ' 
              'However, after completing a form or finish recording a video, you must hit the \'next\' '
              'or \'submit\' button in order for that form or video to be saved\n\n'
              'Q: Am I able to restart my progress?, I have made a mistake\n'
              'A: You are welcome to go back to any point in the form and change your answers or upload '
              'a new video. Keep an eye out for the back button at the top left corner\n\n',
              maxLines: 14,
            ),
            // Toubleshooting section
            SubTitle('Troubleshooting'),
            BodyText(
              'To my knowledge, the only technical issue that could arise is troubles with the camera '
              'make sure to allow the use of the camera wlist on the app, it is critical for this test\n\n'
              'If, for whatever reason, you are stuck, press the below button in order to reset',
              maxLines: 6,
            ),
            RedBodyText('Warning: this button resets all your progress, so only do this if there is no other option', maxLines: 2,),
            ResetButton(camera: camera),
            // Contact information section
            SubTitle('Contact'),
            BodyText(
              'For questions about the app, contact Kevin Li:\n'
              'kevinli200555@gmail.com\n\n'
              'For more information about this project and the AI model, contact Dr Shuo Wang: 314-362-7338\n\n\n',
              maxLines: 8,
            ),
          ],
        ),
      ),
    );
  }
} // EOF help_screen.dart
