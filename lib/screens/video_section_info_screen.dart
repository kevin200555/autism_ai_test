// This screen shows right before the video section, it just gives some basic info that the user must read before recording
// Depending how low this is, I may need to make a second page.

// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/data_gathering/instruction_and_questions.dart';
import 'package:autism_ai_test/data_gathering/video_recording_section.dart';
import 'package:autism_ai_test/themes/colors.dart';
import 'package:autism_ai_test/themes/next_button.dart';
import 'package:autism_ai_test/themes/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoSectionInfoScreen extends StatefulWidget {
  final CameraDescription camera;
  const VideoSectionInfoScreen({super.key, required this.camera});

  @override
  State<VideoSectionInfoScreen> createState() =>
      _VideoSectionInfoScreenState();
}

class _VideoSectionInfoScreenState
    extends State<VideoSectionInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Video Section Information',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyText(
              'Please click the link here to fill out the Informed Consent Document',
            ),
            NextButton(
              label: 'Next',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GuidedVideoRecording(camera: widget.camera, instructions: InstructionAndQuestions.videoInstructions),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
