import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';

class ChooseAllThatApplyQuestionWidget extends StatelessWidget {
  final List<String> multipleChoiceEntry;
  final Function(String) onChanged;
  final String value;

  const ChooseAllThatApplyQuestionWidget({
    super.key,
    required this.multipleChoiceEntry,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final question = multipleChoiceEntry[1];
    final options = multipleChoiceEntry.sublist(2);
    final selected = value.split('|').where((s) => s.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionText(question),
        ...options.map((option) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: CheckboxListTile(
              title: Text(option),
              value: selected.contains(option),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? selectedFlag) {
                final updated = [...selected];
                if (selectedFlag == true) {
                  if (!updated.contains(option)) updated.add(option);
                } else {
                  updated.remove(option);
                }
                onChanged(updated.join('|')); // Save as space-separated string
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
