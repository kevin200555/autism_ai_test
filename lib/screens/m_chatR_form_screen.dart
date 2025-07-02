// just some screening questions
// only yes or no questions
// consider making a serperate type of question that's just for yes or no questions
// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/data_gathering/instruction_and_questions.dart';
import 'package:autism_ai_test/data_gathering/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/data_gathering/short_answer_question_widget.dart';
import 'package:autism_ai_test/screens/video_section_info_screen.dart';
import 'package:autism_ai_test/themes/colors.dart';
import 'package:autism_ai_test/themes/next_button.dart';
import 'package:autism_ai_test/themes/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MChatRFormScreen extends StatefulWidget {
  final CameraDescription camera;
  const MChatRFormScreen({super.key, required this.camera});

  @override
  State<MChatRFormScreen> createState() => _MChatRFormScreenState();
}

class _MChatRFormScreenState extends State<MChatRFormScreen> {
  var mChatRQuestions = InstructionAndQuestions.getMChatR();

  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(mChatRQuestions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: SubTitle('M-CHATR FORM', style: TextStyle(fontSize: 20, color: ColorTheme.alternateTextColor)),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mChatRQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a blank sizedBox at the end (the next button would cover the questions otherwise)
          if (index == mChatRQuestions.length) {
            return NextButton(label: 'NEXT', onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoSectionInfoScreen(camera: widget.camera),
                  ),
                );
              },);
          }
          if (mChatRQuestions[index][0] == 'SAQ') {
            // short answer question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShortAnswerQuestionWidget(
                shortAnswerInstructions: mChatRQuestions[index],
                value: responses[index],
                onChanged: (value) {
                  setState(() {
                    responses[index] = value;
                  });
                },
              ),
            );
          } else {
            // multiple choice question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MutlipleChoiceQuestionWidget(
                multipleChoiceEntry: mChatRQuestions[index],
                value: responses[index],
                onChanged: (value) {
                  setState(() {
                    responses[index] = value;
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
