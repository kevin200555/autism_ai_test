import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_document_screen.dart';
import 'package:autism_ai_test/screens/informed_consent/welcome_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this module is create a button that sits ontop of the appbar
// in the help menu and reset the user's progress
class DeleteButton extends StatelessWidget {
  // takes in camera since that is needed to restart from the beginning)
  final CameraDescription camera;
  const DeleteButton({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        onPressed: () {
          UserClass.resetAll();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(camera: camera)),
          );
        },
        label: ButtonText('DELETE ACCOUNT', maxLines: 1),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorTheme.red,
          foregroundColor: ColorTheme.alternateTextColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
} // EOF help_button.dart
