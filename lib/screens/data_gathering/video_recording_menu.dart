import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecordingMenu extends StatelessWidget {
  final CameraDescription camera;
  const VideoRecordingMenu({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          HelpButton(color: ColorTheme.alternateTextColor, camera: camera),
        ],
        // leading: BackButtonAppBar(),
        title: AppBarTitle(
          'Video Recording Menu',
          color: ColorTheme.alternateTextColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SubTitle('Instructions'),
            BodyText(
              'This is the list of all of the videos you have to take. '
              'Carefully read each set of instructions and decide which one you want to do first. '
              'You are welcome to take these out of order.  As always, feel free to take breaks '
              'and continue when you are ready.',
              maxLines: 6,
            ),
            BodyText(
              'Click the drop down arrow in order to read the task’s instructions.\n',
              maxLines: 4,
            ),
            SubTitle('Tasks'),
          ],
        ),
      ),
    );
  }
}
