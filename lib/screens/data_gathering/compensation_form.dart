// Technically, these questions are part of the intake form, but since that screen is getting crowded
// and this page could potentially include some sensetive information, I decided to make it its own seperate screen


// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions


import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/short_answer_question_widget.dart';
import 'package:autism_ai_test/screens/data_gathering/m_chatr_form_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CompensationFormScreen extends StatefulWidget {
  final CameraDescription camera;
  const CompensationFormScreen({super.key, required this.camera});

  @override
  State<CompensationFormScreen> createState() => _CompensationFormScreenState();
}

class _CompensationFormScreenState extends State<CompensationFormScreen> {
  var compensationFormQuestions = InstructionAndQuestions.getIntakeForm();

  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(compensationFormQuestions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle('INTAKE FORM', color: ColorTheme.alternateTextColor),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: compensationFormQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a next button at the end of all the questions
          if (index == compensationFormQuestions.length) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
                UserClass.intakeResponses = responses;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MChatRFormScreen(camera: widget.camera),
                  ),
                );
              },
            );
          }
          if (compensationFormQuestions[index][0] == 'SAQ') {
            // short answer question
            return ShortAnswerQuestionWidget(
              shortAnswerInstructions: compensationFormQuestions[index],
              value: responses[index],
              onChanged: (value) {
                setState(() {
                  responses[index] = value;
                });
              },
            );
          } else {
            // multiple choice question
            return MutlipleChoiceQuestionWidget(
              multipleChoiceEntry: compensationFormQuestions[index],
              value: responses[index],
              onChanged: (value) {
                setState(() {
                  responses[index] = value;
                });
              },
            );
          }
        },
      ),
    );
  }
} // EOF intake_form_screen.dart
