import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/constants/colors.dart';

//Just diaplays some information of the purpose of this app and how to use it to the user
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'HELP MENU',
          style: TextStyle(fontSize: 24),
          color: ColorTheme.textColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
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
            SubTitle('FAQ'),
            BodyText(
              'Q: \n'
              'A: \n\n'
              'Q: \n'
              'A: \n\n',
              maxLines: 6,
            ),
            SubTitle('Troubleshooting'),
            BodyText('hmmmm, we\'ll find these later\n', maxLines: 2),
            SubTitle('Contact'),
            BodyText(
              'For questions about the app, contact Kevin Li:\n'
              'kevinli200555@gmail.com\n\n'
              'For more information about this project and the AI model, contact Dr Shuo Wang: 314-362-7338',
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
} // EOF help_screen.dart
