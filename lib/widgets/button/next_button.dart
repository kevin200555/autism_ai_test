import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

// This class creates a next button that is reusable throughout all screens
// It's purpose is to direct users to a new screen
class NextButton extends StatelessWidget {
  // changable button lable name as well as a changable onPressed function
  final String label;
  final VoidCallback onPressed;

  const NextButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // creates a boundary area for the button
    return SizedBox(
      width: double.infinity,
      height: 56,
      // keeps the button away from the edges
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Actual Button widget
        child: ElevatedButton.icon(
          onPressed: onPressed,
          // Button Label (doesn't have to say 'next')
          label: ButtonText(
            label,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ColorTheme.alternateTextColor,
              )
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
