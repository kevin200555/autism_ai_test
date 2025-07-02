import 'package:autism_ai_test/widgets/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/widgets/short_answer_question_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/video_recording_section_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';

//Stateful Widget that displays a series of video recording sections that the user must complete
// The user records data for one section, moves on to the next section, and etc
// after the user completes this section, they move unto the video_recording_section
class GuidedQuestionaire extends StatefulWidget {
  final CameraDescription camera;
  final List<List<String>> questionList;
  final List<String> videoInstructions;
  const GuidedQuestionaire({
    super.key,
    required this.camera,
    required this.questionList,
    required this.videoInstructions,
  });

  @override
  State<GuidedQuestionaire> createState() => _GuidedQuestionaireState();
}

class _GuidedQuestionaireState extends State<GuidedQuestionaire> {
  List<String?> responses = [];

  @override
  void initState() {
    super.initState();
    responses = List<String?>.filled(widget.questionList.length, null);
  }

  //goes to the video section
  Future<void> nextSection() async {
    //checks for missing answers before moving on
    if (responses.contains(null)) {
      await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('Please answer all questions')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoRecordingSectionScreen(
            camera: widget.camera,
            instructions: widget.videoInstructions,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Questionaire',
          style: TextStyle(
            color: ColorTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.textColor),
        backgroundColor: ColorTheme.accent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount:
            //the plus 1 is to add a sizedBox (extra space at the end)
            widget.questionList.length + 1,
        itemBuilder: (context, index) {
          //adds a blank sizedBox at the end (the next button would cover the questions otherwise)
          if (index ==
              widget.questionList.length) {
            return Column(
              children: [
                AutoSizeText(
                  'hit the next button when you\'re ready to move on',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            );
          }
          if (widget.questionList[index][0] == 'SAQ') {
            // short answer question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShortAnswerQuestionWidget(
                shortAnswerInstructions: widget.questionList[index],
                value: responses[index],
                onChanged: (value) {
                  setState(() {
                    responses[index] = value;
                  });
                },
              ),
            );
          } 
          else {
            // multiple choice question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MutlipleChoiceQuestionWidget(
                multipleChoiceEntry: widget.questionList[index],
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
      //Next button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Prints to debug console, only enable when using the emulator
          //print(multipleChoiceResponses);
          //print(shortAnswerResponses);
          nextSection();
        },
        backgroundColor: ColorTheme.primary,
        foregroundColor: ColorTheme.textColor,
        child: const Icon(Icons.arrow_forward_sharp),
      ),
    );
  }
}
//EOF questionaire_section.dart