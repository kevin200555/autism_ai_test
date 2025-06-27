import 'package:autism_ai_test/themes/colors.dart';
import 'package:flutter/material.dart';

// makes a widget that lets the user answer a multiple choice question with a dropdown menu, may modify later 
// depending on the type of multiple choice
class MutlipleChoiceQuestionWidget extends StatefulWidget {
  final List<String> multipleChoiceEntry;
  //A list must be passed to this widget, the question is the first item in the list, the choices are the rest of the items
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
  String? selectedValue; //stores user input

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          //question
          Text(
            widget.multipleChoiceEntry[0],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorTheme.alternateTextColor,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.001),
          //answer area
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
