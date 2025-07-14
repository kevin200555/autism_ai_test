// This is the mchat-r form
// It stands for "Modified Checklist for autism in toddlers - Revised"
// only yes or no questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/short_answer_question_widget.dart';
import 'package:autism_ai_test/screens/information_screens/video_section_info_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
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
        title: AppBarTitle(
          'M-CHATR FORM',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mChatRQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a next button at the end of all the questions
          if (index == mChatRQuestions.length) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
                UserClass.mChatRresponses = responses;
                UserClass.printSummary();
                debugPrint(UserClass.generateUserReport());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoSectionInfoScreen(camera: widget.camera),
                  ),
                );
              },
            );
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
} // EOF m_chatr_form_screen.dart
