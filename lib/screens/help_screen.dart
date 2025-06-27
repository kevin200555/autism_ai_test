import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/themes/colors.dart';

//Just diaplays some information of the purpose of this app and how to use it to the user
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Help and Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorTheme.textColor,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.textColor),
        backgroundColor: ColorTheme.accent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: AutoSizeText(
                textAlign: TextAlign.left,
                //edit this string to change the instructions (I'm guessing this is bound to change)
                'Welcome! The purpose of this app is to integrate an AI model that is meant to '
                'determine whether or not the patient has autism or not.  To do that, we need you to'
                'fill out some questionaires and take a few videos of your child'
                'Because of this, we will need access to your camera and audio'
                'After that, your results will be uploaded to the AI model that will determine the likeihood'
                'that your child has autism.  To begin, go back to the home screen and click the start button.'
                'Thank you for helping us, we appreicate your support!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                minFontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//EOF help_screen.dart