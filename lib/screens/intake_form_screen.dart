// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/data_gathering/instruction_and_questions.dart';
import 'package:autism_ai_test/data_gathering/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/data_gathering/short_answer_question_widget.dart';
import 'package:autism_ai_test/screens/m_chatR_form_screen.dart';
import 'package:autism_ai_test/themes/colors.dart';
import 'package:autism_ai_test/themes/next_button.dart';
import 'package:autism_ai_test/themes/text_types.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class IntakeFormScreen extends StatefulWidget {
  final CameraDescription camera;
  const IntakeFormScreen({super.key, required this.camera});

  @override
  State<IntakeFormScreen> createState() => _IntakeFormScreenState();
}

class _IntakeFormScreenState extends State<IntakeFormScreen> {
  var intakeFormQuestions = InstructionAndQuestions.getIntakeForm();

  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(intakeFormQuestions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text('INTAKE FORM', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: intakeFormQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a blank sizedBox at the end (the next button would cover the questions otherwise)
          if (index == intakeFormQuestions.length) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
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
          if (intakeFormQuestions[index][0] == 'SAQ') {
            // short answer question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShortAnswerQuestionWidget(
                shortAnswerInstructions: intakeFormQuestions[index],
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
                multipleChoiceEntry: intakeFormQuestions[index],
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
