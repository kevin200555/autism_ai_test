import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';

// used to get a multiple choice response to a question from the user
class MutlipleChoiceQuestionWidget extends StatelessWidget {
  final List<String> multipleChoiceEntry;
  final Function(String) onChanged;
  final String? value;

  const MutlipleChoiceQuestionWidget({
    super.key,
    required this.multipleChoiceEntry,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // returns a coloum of the quesetion on top, followed a box that contains a dropdown menu of the answer choices
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question
        QuestionText(multipleChoiceEntry[1]),
        // adds spacing for the Dropdown menu
        Padding(
          padding: EdgeInsets.fromLTRB(16, 2, 16, 2),
          // Dropdown menu
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: multipleChoiceEntry
                .sublist(2)
                .map(
                  (item) =>
                      DropdownMenuItem<String>(value: item, child: Text(item)),
                )
                .toList(),
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }
} // EOF multiple_choice_question_widget.dart
