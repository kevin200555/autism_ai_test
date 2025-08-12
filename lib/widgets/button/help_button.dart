import 'package:autism_ai_test/screens/help_screens/help_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this module is create a button that sits ontop of the appbar and direct the user to the
// help menu if they require assistance
// is on most screens, but for screens that are just for displaying information, I'd rather the user read the information
// than pressing the help button
class HelpButton extends StatelessWidget {
  // takes in a color value (I have appbars with different colors )
  final Color color;
  final CameraDescription camera;
  const HelpButton({super.key, required this.color, required this.camera});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.help_outline),
      // sets size
      iconSize: MediaQuery.of(context).size.height * 0.03,
      color: color,
      onPressed: () {
        Navigator.push(
          context,
          // has to take in camera since the user has the option to restart in the help screen
          MaterialPageRoute(builder: (context) => HelpScreen(camera: camera)),
        );
      },
    );
  }
} // EOF help_button.dart
