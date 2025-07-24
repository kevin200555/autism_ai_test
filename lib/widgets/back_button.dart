import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:flutter/material.dart';

class BackButtonAppBar extends StatelessWidget {
  const BackButtonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        UserClass.screenNumber--;
        print('sybau');
        Navigator.of(context).pop();
      }
    );
  }
}