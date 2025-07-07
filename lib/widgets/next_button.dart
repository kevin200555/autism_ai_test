import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/constants/colors.dart';

class NextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const NextButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          label: AutoSizeText(
            label,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ColorTheme.alternateTextColor,
            ),
            maxLines: 1,
            minFontSize: 12,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorTheme.accent,
            foregroundColor: ColorTheme.alternateTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
} // EOF next_button.dart
