import 'package:autism_ai_test/screens/help_screens/help_screen.dart';
import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  final Color color;
  const HelpButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.help_outline),
      iconSize: MediaQuery.of(context).size.width * 0.08, 
      color: color,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpScreen()),
        );
      },
    );
  }
}
