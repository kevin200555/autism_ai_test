// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_signiture.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/progress_bar.dart';
import 'package:autism_ai_test/widgets/questions/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/short_answer_question_widget.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class InformedConsentSigningScreen extends StatefulWidget {
  final CameraDescription camera;
  const InformedConsentSigningScreen({super.key, required this.camera});

  @override
  State<InformedConsentSigningScreen> createState() =>
      _InformedConsentSigningScreenState();
}

class _InformedConsentSigningScreenState
    extends State<InformedConsentSigningScreen> {
  var icQuestions = InstructionAndQuestions.getIC();
  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(icQuestions.length, null);
  }

  // given a sample set of responses like [yes, yes, Sarah Jones, 07/07/2025, null, Tom Jones, Mother, null, Tom Jones]
  // generate a unquie user id sarahjones-20250707-tomjones
  String generateUserId() {
    final name = (responses[2] == null)
        ? 'empty'
        : responses[2]?.toLowerCase().replaceAll(' ', '');
    final parent = (responses[2] == null)
        ? 'empty'
        : responses[4]?.toLowerCase().replaceAll(' ', '');
    //uses the Date time class to give user unquie Id based on date
    final now = DateTime.now();
    final date =
        now.toString().substring(0, 10).replaceAll('-', '').substring(4, 8) +
        now.toString().substring(0, 10).replaceAll('-', '').substring(0, 4);
    final time = now.toString().substring(11, 19).replaceAll(':', '');
    String userId = "$name-$parent-$date-$time";
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          HelpButton(
            color: ColorTheme.alternateTextColor,
            camera: widget.camera,
          ),
        ],
        // leading: BackButtonAppBar(),
        title: AppBarTitle(
          'INFORMED CONSENT FORM',
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
          itemCount: icQuestions.length + 1,
          itemBuilder: (context, index) {
            //adds a next button at the end
            if (index == icQuestions.length) {
              return NextButton(
                label: 'NEXT',
                onPressed: () {
                  UserClass.screenNumber++;
                  //makes a new UserClass in order to save the information this user has done
                  UserClass.userId = generateUserId();

                  UserClass.iCResponses = responses;
                  UserClass.saveToHive();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => // The user class will be passed from sc
                          InformedConsentSignitureScreen(
                            camera: widget.camera,
                          ),
                    ),
                  );
                },
              );
            }
            if (icQuestions[index][0] == 'SAQ') {
              // make an SAQ question
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
            } else {
              // make a multiple choice question
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
      ),
    );
  }
} // EOF ic_document_signing.dart
