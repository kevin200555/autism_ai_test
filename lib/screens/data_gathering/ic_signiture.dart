// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/information_screens/video_section_info_screen.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/signiture_question_widget.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class InformedConsentSignitureScreen extends StatefulWidget {
  final CameraDescription camera;
  const InformedConsentSignitureScreen({super.key, required this.camera});

  @override
  State<InformedConsentSignitureScreen> createState() =>
      _InformedConsentSignitureScreenState();
}

class _InformedConsentSignitureScreenState
    extends State<InformedConsentSignitureScreen> {
  var signitureQuestions = InstructionAndQuestions.getSigniture();
  var userId = '';
  //List<String?> responses = [];
  //Honestly not sure how I should handle responses here, I think I'll just wait
  @override
  void initState() {
    super.initState();
    //responses = List<String?>.filled(signitureQuestions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle('SIGNITURE', color: ColorTheme.alternateTextColor),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DrawingQuestionWidget(question: signitureQuestions[0][1]),
          DrawingQuestionWidget(question: signitureQuestions[1][1]),
          NextButton(
            label: 'NEXT',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoSectionInfoScreen(camera: widget.camera),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} // EOF ic_document_signing.dart
