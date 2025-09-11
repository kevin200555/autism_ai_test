import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/main_menu/home_menu_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/back_button.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/app_bar_gradient.dart';
import 'package:autism_ai_test/widgets/questions/radio_multiple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/short_answer_question_widget.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Technically, these questions are part of the intake form, but since that screen is getting crowded
// and this page could potentially include some sensetive information, I decided to make it its own seperate screen
// This screen asks the user if they would like to be compensated for the experiment, to do this it
class CompensationFormScreen extends StatefulWidget {
  final CameraDescription camera;
  const CompensationFormScreen({super.key, required this.camera});

  @override
  State<CompensationFormScreen> createState() => _CompensationFormScreenState();
}

class _CompensationFormScreenState extends State<CompensationFormScreen> {
  var compensationFormQuestions = InstructionAndQuestions.getCQuestions();
  // stores responses
  List<String?> responses = UserClass.compensationResponses ?? [];

  @override
  void initState() {
    super.initState();

    responses = List<String?>.filled(compensationFormQuestions.length, null);

    final prevResponses = UserClass.compensationResponses;
    if (prevResponses != null) {
      for (int i = 0; i < prevResponses.length && i < responses.length; i++) {
        responses[i] = prevResponses[i];
      }
    }
  }

  @override
  // This is the main widget that holds the compensation form screen
  // It has an app bar, a body with the questions, and a next button at
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
          'COMPENSATION FORM',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
        flexibleSpace: AppBarGradient(),
      ),

      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: compensationFormQuestions.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return BodyText(
                'This information is required for compensation. '
                'If you wish to decline payment, you can leave these fields blank.\n\n',
                color: ColorTheme.red,
              );
            } else if (index == compensationFormQuestions.length + 1) {
              // LAST index (after all questions)
              return NextButton(
                label: 'SUBMIT FORM',
                onPressed: () {
                  UserClass.currentScreen = "main_menu";
                  UserClass.compensationResponses = responses;
                  UserClass.saveToHive();
                  UserClass.generateCompensationReport();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeMenuScreen(camera: widget.camera),
                    ),
                  );
                },
              );
            } else {
              // Adjusted question index
              int questionIndex = index - 1;

              if (compensationFormQuestions[questionIndex][0] == 'SAQ') {
                return ShortAnswerQuestionWidget(
                  shortAnswerInstructions:
                      compensationFormQuestions[questionIndex],
                  value: responses[questionIndex],
                  onChanged: (value) {
                    setState(() {
                      responses[questionIndex] = value;
                    });
                  },
                );
              } else {
                return RadioMutlipleChoiceQuestionWidget(
                  multipleChoiceEntry: compensationFormQuestions[questionIndex],
                  value: responses[questionIndex],
                  onChanged: (value) {
                    setState(() {
                      responses[questionIndex] = value;
                    });
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
} // EOF intake_form_screen.dart
