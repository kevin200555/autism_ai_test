import 'package:flutter/material.dart';
import 'package:autism_ai_test/themes/colors.dart';

class ShortAnswerQuestionWidget extends StatefulWidget {
  final String shortAnswerInstructions;
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

class _ShortAnswerQuestionWidgetState
    extends State<ShortAnswerQuestionWidget> {
  //controller is used because when you scroll, it removes the list item, removing whatever the user put in there
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(covariant ShortAnswerQuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question prompt
          Text(
            widget.shortAnswerInstructions,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorTheme.alternateTextColor,
            ),
          ),
          const SizedBox(height: 12),
          // Answer input field
          TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter your answer here',
            ),
            style: const TextStyle(fontSize: 18),
            maxLines: 5,
            minLines: 1,
          ),
        ],
      ),
    );
  }
}
//EOF short_answer_question_widget.dart