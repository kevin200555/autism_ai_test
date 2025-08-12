import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
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
        // Question Text
        QuestionText(multipleChoiceEntry[1]),
        // adds spacing for the Dropdown menu
        Padding(
          padding: EdgeInsets.fromLTRB(16, 2, 16, 2),
          // Dropdown menu
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            // the hint text that shows where the user is supposed to answer the question
            hint: QuestionBodyText(
              'click to answer',
              maxLines: 1,
              isItalics: true,
            ),
            // takes the list after index position [1] and displays them as answer choices
            items: multipleChoiceEntry
                .sublist(2)
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: BodyText(item, color: ColorTheme.textColor),
                  ),
                )
                .toList(),
            // changes the value if the user picks another option
            onChanged: (val) {
              if (val != null) onChanged(val);
            },
          ),
        ),
      ],
    );
  }
} // EOF multiple_choice_question_widget.dart
