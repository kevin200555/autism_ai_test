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
      iconSize: MediaQuery.of(context).size.height * 0.05,
      onPressed: () {
        // makes sure that there is something in the stack before running navigator.
        // This is because when reloaded a savfe file, that stack is lost
        if (Navigator.canPop(context)) {
          UserClass.screenNumber--;
          Navigator.of(context).pop();
        }
      },
    );
  }
} // EOF back_button.dart
