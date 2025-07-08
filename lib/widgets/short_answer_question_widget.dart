import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question prompt
        QuestionText(widget.shortAnswerInstructions[1]),
        // Answer input field
        Padding(
          padding: EdgeInsets.fromLTRB(16, 2, 16, 2),
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter your answer here',
            ),
            style: const TextStyle(fontSize: 14),
            maxLines: 5,
            minLines: 1,
          ),
        ),
      ],
    );
  }
}
//EOF short_answer_question_widget.dart