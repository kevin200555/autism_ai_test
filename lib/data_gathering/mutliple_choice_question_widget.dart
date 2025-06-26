import 'package:autism_ai_test/themes/colors.dart';
import 'package:flutter/material.dart';

class MutlipleChoiceQuestionWidget extends StatefulWidget {
  final List<String> multipleChoiceEntry;
  final Function(String) onChanged;
  const MutlipleChoiceQuestionWidget({
    super.key,
    required this.multipleChoiceEntry,
    required this.onChanged,
  });

  @override
  State<MutlipleChoiceQuestionWidget> createState() =>
      _MutlipleChoiceQuestionWidgetState();
}

class _MutlipleChoiceQuestionWidgetState
    extends State<MutlipleChoiceQuestionWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.multipleChoiceEntry[0],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorTheme.alternateTextColor,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            value: selectedValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: widget.multipleChoiceEntry
                .sublist(1, widget.multipleChoiceEntry.length)
                .map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                })
                .toList(),
            onChanged: (value) {
              selectedValue = value;
              widget.onChanged(value ?? '');
            }
          ),
        ],
      ),
    );
  }
}
