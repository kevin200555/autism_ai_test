import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/delete_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this screen is to actually display the informed_consent answers back to the user
// Since that form can't be edited, I feel this is good to do
// Also, it contains a delelte account button that resets user data
// good for debugging, but if the user made a mistake on the informed_conset, it could be good for them too 
class SettingsScreen extends StatelessWidget {
  final CameraDescription camera;

  const SettingsScreen({super.key, required this.camera});

  // This function gets the date from the user's userID
  // This could be a function to put in user class, but I also feel like the settings screen would be the only place for it
  String getDate(String? userId) {
    if (userId == null) {
      return 'No information given';
    }
    List<String> temp = userId.split('-');
    return '${temp[2].substring(0, 2)}/${temp[2].substring(2, 4)}/${temp[2].substring(4)}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle('Profile'),
          BodyText(
            'This is your profile! All of this information is gathered from your '
            'responses to the Informed Consent Document.\n',
            color: ColorTheme.textColor,
          ),
          SubTitle('Name of Child: '),
          BodyText(
            '${UserClass.iCResponses?[2]}\n',
            color: ColorTheme.textColor,
          ),
          SubTitle('Name of Parent: '),
          BodyText(
            '${UserClass.iCResponses?[4]}\n',
            color: ColorTheme.textColor,
          ),
          SubTitle('Date of account creation: '),
          BodyText(
            '${getDate(UserClass.userId)}\n',
            color: ColorTheme.textColor,
          ),
          SubTitle('UserId: '),
          BodyText('${UserClass.userId}\n', color: ColorTheme.textColor),
          SubTitle('Amount of video recording sessions: '),
          BodyText(
            '${UserClass.videos.length}\n\n\n',
            color: ColorTheme.textColor,
          ),
          // Delete Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: DeleteButton(camera: camera),
          ),
        ],
      ),
    );
  }
} // EOF settings_screen.dart
