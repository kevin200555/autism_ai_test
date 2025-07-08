// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/m_chatr_form_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/signiture_question_widget.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class InformedConsentSignitureScreen extends StatefulWidget {
  final CameraDescription camera;
  const InformedConsentSignitureScreen({super.key, required this.camera});

  @override
  State<InformedConsentSignitureScreen> createState() => _InformedConsentSignitureScreenState();
}

class _InformedConsentSignitureScreenState extends State<InformedConsentSignitureScreen> {
  var signitureQuestions = InstructionAndQuestions.getSigniture();
  var userId = '';
  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(signitureQuestions.length, null);
  }
  // given a sample set of responses like [yes, yes, Sarah Jones, 07/07/2025, null, Tom Jones, Mother, null, Tom Jones]
  // generate a unquie user id sarahjones-20250707-tomjones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle('SIGNITURE', color: ColorTheme.alternateTextColor),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: signitureQuestions.length + 1,
        itemBuilder: (context, index) {
          //adds a next button at the end
          if (index == 0) {
            return NextButton(
              label: 'NEXT',
              onPressed: () {
                //print(widget.userId);
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
          
          if (signitureQuestions[index][0] == 'SQ'){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DrawingQuestionWidget(
                question: signitureQuestions[index][1],
              ),
            );
          }
          
        },
      ),
    );
  }
} // EOF ic_document_signing.dart 
