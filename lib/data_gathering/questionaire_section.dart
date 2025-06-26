import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:autism_ai_test/data_gathering/video_recording_section.dart';
import 'package:autism_ai_test/themes/colors.dart';

//Stateful Widget that displays a series of video recording sections that the user must complete
// The user records data for one section, moves on to the next section, and etc
// after the user completes this section, they move unto the video_recording_section
class GuidedQuestionaire extends StatefulWidget {
  final CameraDescription camera;
  final List<String> shortAnswerInstructions;
  final List<String> multipleChoice;
  final List<String> videoInstructions;
  const GuidedQuestionaire({
    super.key,
    required this.camera,
    required this.shortAnswerInstructions,
    required this.multipleChoice,
    required this.videoInstructions,
  });

  @override
  State<GuidedQuestionaire> createState() => _GuidedQuestionaireState();
}

class _GuidedQuestionaireState extends State<GuidedQuestionaire> {
  int currentSurvey = 0;
  void nextSurvey() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuidedVideoRecording(
          camera: widget.camera,
          instructions: widget.videoInstructions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Questionaire}',
          style: TextStyle(
            color: ColorTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.textColor),
        backgroundColor: ColorTheme.accent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [

        ]
      )
    );
  }
}
//EOF questionaire_section.dart