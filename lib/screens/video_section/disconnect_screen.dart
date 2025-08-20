import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/video_section/video_recording_menu.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this class is to ease the user back in after they disconnected from a video session
class DisconnectScreen extends StatelessWidget {
  final CameraDescription camera;
  const DisconnectScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ImportantBodyText(
            'Hey it seemed like you disconnected during your last video recording session '
            'No worries! Your progress was saved and feel free to continue where you left off\n',
            color: ColorTheme.textColor,
          ),
          NextButton(
            label: 'Next',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoRecordingMenu(camera: camera),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
