import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/intake/compensation_form.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/back_button.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/progress_bar.dart';
import 'package:autism_ai_test/widgets/questions/choose_all_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/short_answer_question_widget.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this class is to implement the intake form questionaire
// It is a mix of multiple choice and short answer questions meant to take some basic information about the child and parent
// I split this form into two seperate screens: one for the child, one for the parent
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
        actions: [
          HelpButton(
            color: ColorTheme.alternateTextColor,
            camera: widget.camera,
          ),
        ],
        title: AppBarTitle(
          'INTAKE FORM: CHILD',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
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
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
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
      ),
      bottomNavigationBar: ProgressBar(),
    );
  }
}

// second half of the intake form
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
        actions: [
          HelpButton(
            color: ColorTheme.alternateTextColor,
            camera: widget.camera,
          ),
        ],
        title: AppBarTitle(
          'INTAKE FORM: PARENT/GUARDIAN',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: intakeFormQuestions.length + 1,
          itemBuilder: (context, index) {
            //adds a next button at the end of all the questions
            if (index == intakeFormQuestions.length) {
              return NextButton(
                label: 'NEXT',
                onPressed: () {
                  // SAVE TO HIVE
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
      ),
      bottomNavigationBar: ProgressBar(),
    );
  }
} // EOF intake_form_screen.dart
