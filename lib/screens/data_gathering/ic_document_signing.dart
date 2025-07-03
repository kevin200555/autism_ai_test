// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/widgets/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/short_answer_question_widget.dart';
import 'package:autism_ai_test/screens/data_gathering/m_chatr_form_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/signiture_question_widget.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class InformedConsentSigningScreen extends StatefulWidget {
  final CameraDescription camera;
  const InformedConsentSigningScreen({super.key, required this.camera});

  @override
  State<InformedConsentSigningScreen> createState() => _InformedConsentSigningScreenState();
}

class _InformedConsentSigningScreenState extends State<InformedConsentSigningScreen> {
  var icQuestions = InstructionAndQuestions.getIC();

  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(icQuestions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: SubTitle('INTAKE FORM', style: TextStyle(fontSize: 18, color: ColorTheme.alternateTextColor)),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: icQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a blank sizedBox at the end (the next button would cover the questions otherwise)
          if (index == icQuestions.length) {
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
          if (icQuestions[index][0] == 'SAQ') {
            // short answer question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShortAnswerQuestionWidget(
                shortAnswerInstructions: icQuestions[index],
                value: responses[index],
                onChanged: (value) {
                  setState(() {
                    responses[index] = value;
                  });
                },
              ),
            );
          } 
          else if (icQuestions[index][0] == 'SQ'){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DrawingQuestionWidget(
                question: icQuestions[index][1],
              ),
            );
          }
          else {
            // multiple choice question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MutlipleChoiceQuestionWidget(
                multipleChoiceEntry: icQuestions[index],
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
