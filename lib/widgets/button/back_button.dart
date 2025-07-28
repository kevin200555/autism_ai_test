import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:flutter/material.dart';

// The purpose of this class is to override the default back button in scafold appbar
// Since I'm keeping track of the screen number, the back button needs to update the screen number when it is pressed
// the default back button obvisouly can't do that, so I must override it here
class BackButtonAppBar extends StatelessWidget {
  const BackButtonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: MediaQuery.of(context).size.width * 0.075, 
      onPressed: () {
        UserClass.screenNumber--;
        Navigator.of(context).pop();
      },
    );
  }
} // EOF back_button.dart
