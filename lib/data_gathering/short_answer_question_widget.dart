import 'package:autism_ai_test/themes/colors.dart';
import 'package:flutter/material.dart';

//makes a widget that lets the user type out an answer to a question
class ShortAnswerQuestionWidget extends StatefulWidget {
  final String shortAnswerInstructions;
  final Function(String) onChanged;

  const ShortAnswerQuestionWidget({
    super.key,
    required this.shortAnswerInstructions,
    required this.onChanged,
  });

  @override
  State<ShortAnswerQuestionWidget> createState() =>
      _ShortAnswerQuestionWidgetState();
}

class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
  String userInput = ''; //stores user input
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.shortAnswerInstructions,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorTheme.alternateTextColor,
            ),
          ),//displays the question
          const SizedBox(height: 4),
          //displays answer box
          TextFormField(
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your answer',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
//EOF short_answer_question.dart