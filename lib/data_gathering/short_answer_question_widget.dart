import 'package:autism_ai_test/themes/colors.dart';
import 'package:flutter/material.dart';

class ShortAnswerQuestionWidget extends StatefulWidget {
  final String shortAnswerInstructions;
  const ShortAnswerQuestionWidget({
    super.key,
    required this.shortAnswerInstructions,
  });

  @override
  State<ShortAnswerQuestionWidget> createState() => _ShortAnswerQuestionWidgetState();
}

class _ShortAnswerQuestionWidgetState extends State<ShortAnswerQuestionWidget> {
  String userInput = '';
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
          ),
          const SizedBox(height: 4),
          TextFormField(
            onChanged: (value) {
              setState(() {
                userInput = value;
              });
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
