import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';
// The purpose of this screen is a error screen 
// that would only appear if the user doesn't have a camera on their device
// I REALLY hope this doesn't happen because there isn't really a way to fix it beyond just get something with a camera
class NoCameraErrorScreen extends StatelessWidget {
  const NoCameraErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: BodyText('So you\'re REALLY not meant to see this screen so '
        'if you\'re seeing this, it probably means that something is wrong with your camera '
        'or if you don\'t have a camera, either way contact Kevin Li (kevinli200555@gmail.com) '
        'and let me know what device you are using and we\'ll figure out what went wrong'
        'Sorry for the inconvience',
        color: ColorTheme.textColor,),
      ),
    );
  }
} // EOF no_camera_error_screen.dart
