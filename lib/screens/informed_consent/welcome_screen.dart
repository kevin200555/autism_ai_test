import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_document_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final CameraDescription camera;

  const WelcomeScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarTitle('Welcome!', color: ColorTheme.background),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),

            child: Text(
              'Thank you for downloading the app! Your support means a lot and we appreciate your time. '
              'This app\'s purpose is to use AI to help determine whether or not a child has autism.\n\n'
              'Before we get started, we need you to read over the document on the next page and get your names and signitures',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                color: ColorTheme.textColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

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
    );
  }
}
