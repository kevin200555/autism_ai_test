import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/main_menu/home_menu_screen.dart';
import 'package:autism_ai_test/uploading/video_storage_class.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this module is create a button that sits ontop of the appbar
// in the help menu and reset the user's progress
class BackToMainMenu extends StatelessWidget {
  // takes in camera since that is needed to restart from the beginning)
  final CameraDescription camera;
  const BackToMainMenu({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton.icon(
        onPressed: () {
          VideoStorageClassItem.resetAll();
          // takes the user back to the home menu screen
          // deletes all video progress
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeMenuScreen(camera: camera)),
          );
        },
        label: ButtonText('BACK TO MAIN MENU', maxLines: 1),
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
