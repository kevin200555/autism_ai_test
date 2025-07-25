// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/compensation_form.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/back_button.dart';
import 'package:autism_ai_test/widgets/progress_bar.dart';
import 'package:autism_ai_test/widgets/questions/choose_all_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/short_answer_question_widget.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ChildIntakeFormScreen extends StatefulWidget {
  final CameraDescription camera;
  const ChildIntakeFormScreen({super.key, required this.camera});

  @override
  State<ChildIntakeFormScreen> createState() => _ChildIntakeFormScreenState();
}

class _ChildIntakeFormScreenState extends State<ChildIntakeFormScreen> {
  var intakeFormQuestions = InstructionAndQuestions.getChildIntakeForm();

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
        leading: BackButtonAppBar(),
        title: AppBarTitle('INTAKE FORM: CHILD', color: ColorTheme.alternateTextColor),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: intakeFormQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a next button at the end of all the questions
          if (index == intakeFormQuestions.length) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
                UserClass.screenNumber++;
                UserClass.childIntakeResponses = responses;
                UserClass.saveToHive();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ParentIntakeFormScreen(camera: widget.camera),
                  ),
                );
              },
            );
          }
          if (intakeFormQuestions[index][0] == 'SAQ') {
            // short answer question
            return ShortAnswerQuestionWidget(
              shortAnswerInstructions: intakeFormQuestions[index],
              value: responses[index],
              onChanged: (value) {
                setState(() {
                  responses[index] = value;
                });
              },
            );
          } else if (intakeFormQuestions[index][0] == 'CATAQ') {
            // short answer question
            return ChooseAllThatApplyQuestionWidget(
              multipleChoiceEntry: intakeFormQuestions[index],
              value: responses[index] ?? "",
              onChanged: (updatedString) {
                setState(() {
                  responses[index] = updatedString;
                });
              },
            );
          } else {
            // multiple choice question
            return MutlipleChoiceQuestionWidget(
              multipleChoiceEntry: intakeFormQuestions[index],
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
      bottomNavigationBar: ProgressBar(),
    );
  }
}

class ParentIntakeFormScreen extends StatefulWidget {
  final CameraDescription camera;
  const ParentIntakeFormScreen({super.key, required this.camera});

  @override
  State<ParentIntakeFormScreen> createState() => _ParentIntakeFormScreenState();
}

class _ParentIntakeFormScreenState extends State<ParentIntakeFormScreen> {
  var intakeFormQuestions = InstructionAndQuestions.getParentIntakeForm();

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
        leading: BackButtonAppBar(),
        title: AppBarTitle('INTAKE FORM: PARENT/GUARDIAN', color: ColorTheme.alternateTextColor),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: intakeFormQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a next button at the end of all the questions
          if (index == intakeFormQuestions.length) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
                UserClass.screenNumber++;
                UserClass.parentIntakeResponses = responses;
                UserClass.saveToHive();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CompensationFormScreen(camera: widget.camera),
                  ),
                );
              },
            );
          }
          if (intakeFormQuestions[index][0] == 'SAQ') {
            // short answer question
            return ShortAnswerQuestionWidget(
              shortAnswerInstructions: intakeFormQuestions[index],
              value: responses[index],
              onChanged: (value) {
                setState(() {
                  responses[index] = value;
                });
              },
            );
          } else if (intakeFormQuestions[index][0] == 'CATAQ') {
            // short answer question
            return ChooseAllThatApplyQuestionWidget(
              multipleChoiceEntry: intakeFormQuestions[index],
              value: responses[index] ?? "",
              onChanged: (updatedString) {
                setState(() {
                  responses[index] = updatedString;
                });
              },
            );
          } else {
            // multiple choice question
            return MutlipleChoiceQuestionWidget(
              multipleChoiceEntry: intakeFormQuestions[index],
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
      bottomNavigationBar: ProgressBar(),
    );
  }
}

// EOF intake_form_screen.dart
