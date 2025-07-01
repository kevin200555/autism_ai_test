import 'package:autism_ai_test/themes/text_types.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question
          SubTitle(multipleChoiceEntry[1]),
          // Dropdown menu
          DropdownButton<String>(
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
        ],
      ),
    );
  }
}
//EOF multiple_choice_question_widget.dart