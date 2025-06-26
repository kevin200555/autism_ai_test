import 'package:autism_ai_test/data_gathering/mutliple_choice_question_widget.dart';
import 'package:autism_ai_test/data_gathering/short_answer_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/data_gathering/video_recording_section.dart';
import 'package:autism_ai_test/themes/colors.dart';

//Stateful Widget that displays a series of video recording sections that the user must complete
// The user records data for one section, moves on to the next section, and etc
// after the user completes this section, they move unto the video_recording_section
class GuidedQuestionaire extends StatefulWidget {
  final CameraDescription camera;
  final List<String> shortAnswerInstructions;
  final List<List<String>> multipleChoice;
  final List<String> videoInstructions;
  const GuidedQuestionaire({
    super.key,
    required this.camera,
    required this.shortAnswerInstructions,
    required this.multipleChoice,
    required this.videoInstructions,
  });

  @override
  State<GuidedQuestionaire> createState() => _GuidedQuestionaireState();
}

class _GuidedQuestionaireState extends State<GuidedQuestionaire> {
  List<String?> shortAnswerResponses = [];
  List<String?> multipleChoiceResponses = [];

  @override
  void initState() {
    super.initState();
    shortAnswerResponses = List<String?>.filled(
      widget.shortAnswerInstructions.length,
      null,
    );
    multipleChoiceResponses = List<String?>.filled(
      widget.multipleChoice.length,
      null,
    );
  }

  void nextSection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuidedVideoRecording(
          camera: widget.camera,
          instructions: widget.videoInstructions,
        ),
      ),
    );
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
            widget.shortAnswerInstructions.length +
            widget.multipleChoice.length +
            1,
        itemBuilder: (context, index) {
          //adds the sizedBox at the end (it would cover the next button otherwise)
          if (index ==
              widget.shortAnswerInstructions.length +
                  widget.multipleChoice.length) {
            return const SizedBox(height: 80);
          }
          if (index < widget.shortAnswerInstructions.length) {
            // short answer question
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShortAnswerQuestionWidget(
                shortAnswerInstructions: widget.shortAnswerInstructions[index],
                onChanged: (value) {
                  setState(() {
                    shortAnswerResponses[index] = value;
                  });
                },
              ),
            );
          } else {
            // multiple choice question
            final mcIndex = index - widget.shortAnswerInstructions.length;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MutlipleChoiceQuestionWidget(
                multipleChoiceEntry: widget.multipleChoice[mcIndex],
                onChanged: (value) {
                  setState(() {
                    multipleChoiceResponses[mcIndex] = value;
                  });
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(multipleChoiceResponses);
          print(shortAnswerResponses);

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