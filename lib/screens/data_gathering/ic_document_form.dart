// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/ic_signiture.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/progress_bar.dart';
import 'package:autism_ai_test/widgets/questions/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/questions/short_answer_question_widget.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
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
    final name = responses[2]?.toLowerCase().replaceAll(' ', '');
    final date = responses[3]?.replaceAll('/', '');
    final parent = responses[4]?.toLowerCase().replaceAll(' ', '');
    String userId = "$name-$date-$parent";
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          HelpButton(color: ColorTheme.alternateTextColor, camera: widget.camera)
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

      body: ListView.builder(
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
      bottomNavigationBar: ProgressBar(),
    );
  }
} // EOF ic_document_signing.dart
