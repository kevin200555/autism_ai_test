import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

// This is a question that lets the user choose all that apply
// this is only for one quesition about the user's race
// The response is stored in a String like this: "white|asian|..."
// I wasn't going to make the response a 2D array becuase that would require I make a lot of other things a 2D array
// this may be a bit much for one question
class ChooseAllThatApplyQuestionWidget extends StatelessWidget {
  final List<String> multipleChoiceEntry;
  final Function(String) onChanged;
  final String value;
  //formatted the same as multiple choice entry
  const ChooseAllThatApplyQuestionWidget({
    super.key,
    required this.multipleChoiceEntry,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    //stores the quesition and the options
    final question = multipleChoiceEntry[1];
    final options = multipleChoiceEntry.sublist(2);
    // splits the string with |
    // I would do space, but the multiple choice options have spaces already
    final selected = value.split('|').where((s) => s.isNotEmpty).toList();
    // returns a coloum of the quesetion on top, followed by a list of the answer choices
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionText(question),
        ...options.map((option) {
          // adds spacing to the answer choices
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            // answer choices
            child: CheckboxListTile(
              title: QuestionBodyText(option, maxLines: 1, isItalics: false),
              activeColor: ColorTheme.accent,
              value: selected.contains(option),
              controlAffinity: ListTileControlAffinity.leading,
              // check/remove if updated
              onChanged: (bool? selectedFlag) {
                final updated = [...selected];
                if (selectedFlag == true) {
                  if (!updated.contains(option)) updated.add(option);
                } else {
                  updated.remove(option);
                }
                onChanged(
                  updated.join('|'),
                ); // Save as space-separated string except instead of space it is '|'
              },
            ),
          );
        }),
      ],
    );
  }
} // EOF choose_all_question_widget.dart
