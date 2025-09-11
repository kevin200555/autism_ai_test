import 'package:autism_ai_test/constants/colors.dart';
import 'package:flutter/material.dart';

// This widget is used to create a gradient background for the app bar
// It uses a radial gradient that transitions from the accent color to the primary color
class AppBarGradient extends StatelessWidget {
  const AppBarGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [ColorTheme.accent, ColorTheme.primary],
          center: Alignment.center,
          radius: MediaQuery.of(context).size.width * 0.0115,
        ),
      ),
    );
  }
} // EOF app_bar_gradient.dart
