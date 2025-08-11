import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

// used to get a multiple choice response to a question from the user
class RadioMutlipleChoiceQuestionWidget extends StatelessWidget {
  final List<String> multipleChoiceEntry;
  final Function(String) onChanged;
  final String? value;

  const RadioMutlipleChoiceQuestionWidget({
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: multipleChoiceEntry.sublist(2).map((item) {
              return RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: QuestionBodyText(item, maxLines: 1, isItalics: false,),
                value: item,
                groupValue: value,
                onChanged: (val) {
                  if (val != null) onChanged(val);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
} // EOF multiple_choice_question_widget.dart
