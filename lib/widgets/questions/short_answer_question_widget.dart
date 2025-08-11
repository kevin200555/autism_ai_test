import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This class' creates a widget that is meant to get some typed response from the user
// It is used in the various forms in this experiment
class ShortAnswerQuestionWidget extends StatefulWidget {
  final List<String> shortAnswerInstructions;
  final Function(String) onChanged;
  final String? value;

  const ShortAnswerQuestionWidget({
    super.key,
    required this.shortAnswerInstructions,
    required this.onChanged,
    required this.value,
  });

  @override
  State<ShortAnswerQuestionWidget> createState() =>
      _ShortAnswerQuestionWidgetState();
}

class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
  // controller is used because when you scroll,
  // it removes the list item, removing whatever the user put in there
  // controller makes sure the user's answers are saved
  late TextEditingController _controller;

  // initizes the controller
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
  }

  // checks for whether or not the user updated the answer box
  @override
  void didUpdateWidget(covariant ShortAnswerQuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
    }
  }

  // gets rid of the controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // returns a coloum of the quesetion on top, followed an answer box where the user can type their answer
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question prompt
        QuestionText(widget.shortAnswerInstructions[1]),
        // keeps answer box away from the edges
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          // answer box widget
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Type your answer here',
            ),
            style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic
                        ),
                      ),
            maxLines: 5,
            minLines: 1,
          ),
        ),
      ],
    );
  }
}
// EOF short_answer_question_widget.dart