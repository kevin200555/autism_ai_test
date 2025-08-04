// This is the mchat-r form
// It stands for "Modified Checklist for autism in toddlers - Revised"
// only yes or no questions

// ignore_for_file: file_names

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/information_screens/video_section_info_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/back_button.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/progress_bar.dart';
import 'package:autism_ai_test/widgets/questions/radio_multiple_choice_question_widget.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This class implements the mChatR form, a questionaire made up of 100% multiple choice questions used to
// test for autism based on 20 questions
// It uses the Radio multiple choice question widget to do this
// It is split into 2 screens for less scrolling
class MChatRFormScreen1 extends StatefulWidget {
  final CameraDescription camera;
  const MChatRFormScreen1({super.key, required this.camera});

  @override
  State<MChatRFormScreen1> createState() => _MChatRFormScreen1State();
}

class _MChatRFormScreen1State extends State<MChatRFormScreen1> {
  var mChatRQuestions = InstructionAndQuestions.getMChatR();

  List<String?> responses = [];
  // half refers to half of the mChatRquestions
  int half = 0;
  @override
  void initState() {
    super.initState();
    half = (mChatRQuestions.length / 2).ceil();
    responses = List<String?>.filled(mChatRQuestions.length, null);
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
          'M-CHATR FORM: Page 1 of 2',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: half + 1,
        itemBuilder: (context, index) {
          //adds a next button at the end of all the questions
          if (index == half) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
                // SAVE TO HIVE
                UserClass.screenNumber++;
                UserClass.mChatRresponses = responses;
                UserClass.saveToHive();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MChatRFormScreen2(
                      camera: widget.camera,
                      responses: responses,
                    ),
                  ),
                );
              },
            );
          }
          // multiple choice question
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RadioMutlipleChoiceQuestionWidget(
              multipleChoiceEntry: mChatRQuestions[index],
              value: responses[index],
              onChanged: (newValue) {
                setState(() {
                  responses[index] = newValue;
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: ProgressBar(),
    );
  }
}

// Second screen of the MChatRForm
// important to note that it takes in responses from the previous screen
// This is so that both screens update the same response list
class MChatRFormScreen2 extends StatefulWidget {
  final CameraDescription camera;
  final List<String?> responses;

  const MChatRFormScreen2({
    super.key,
    required this.camera,
    required this.responses,
  });

  @override
  State<MChatRFormScreen2> createState() => _MChatRFormScreen2State();
}

class _MChatRFormScreen2State extends State<MChatRFormScreen2> {
  late List<List<String>> mChatRQuestions;
  late int half;

  @override
  void initState() {
    super.initState();
    mChatRQuestions = InstructionAndQuestions.getMChatR();
    half = (mChatRQuestions.length / 2).ceil();
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
          'M-CHATR FORM: Page 2 of 2',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: (mChatRQuestions.length - half) + 1, // +1 for SUBMIT button
        itemBuilder: (context, index) {
          if (index == mChatRQuestions.length - half) {
            return NextButton(
              label: 'SUBMIT',
              onPressed: () async {
                // SAVE TO HIVE
                if (kDebugMode) {
                  print(UserClass.parentIntakeResponses);
                  print(UserClass.compensationResponses);
                  print(UserClass.mChatRresponses);
                }
                UserClass.screenNumber++;
                UserClass.mChatRresponses = widget.responses;
                await UserClass.saveToHive();
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GeneralInstructionsScreen(camera: widget.camera),
                  ),
                );
              },
            );
          }

          final qIndex = half + index;
          final question = mChatRQuestions[qIndex];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RadioMutlipleChoiceQuestionWidget(
              multipleChoiceEntry: question,
              value: widget.responses[qIndex],
              onChanged: (newValue) {
                setState(() {
                  widget.responses[qIndex] = newValue;
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: ProgressBar(),
    );
  }
} // EOF m_chatr_form_screen.dart
