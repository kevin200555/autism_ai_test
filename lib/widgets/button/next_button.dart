import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

// This class creates a next button that is reusable throughout all screens
// It's purpose is to direct users to a new screen
class NextButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const NextButton({super.key, required this.label, required this.onPressed});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 1.025); // grow slightly
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0); // back to normal
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0); // cancel press
  }

  @override
  Widget build(BuildContext context) {
    // This is the main widget that holds the next button
    // It is an elevated button with an icon and a label
    // The button is styled with a background color, foreground color, and shape
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          // Detects taps and animates the button
          // onTapDown makes the button grow slightly
          // onTapUp makes the button go back to normal and triggers the onPressed function
          // onTapCancel makes the button go back to normal if the tap is cancelled
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          // The AnimatedScale widget animates the scaling of the button
          // The ElevatedButton.icon widget creates the button with an icon and a label
          // The ButtonText widget styles the label text
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme.accentShadow,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton.icon(
                onPressed: widget
                    .onPressed, // still works with keyboard / accessibility
                label: ButtonText(
                  widget.label,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.alternateTextColor,
                    ),
                  ),
                  maxLines: 1,
                  minFontSize: 12,
                ),
                // Icon next to the label
                // Using Icons.arrow_forward for a right arrow
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
          ),
        ),
      ),
    );
    ;
  }
} // EOF next_button.dart
