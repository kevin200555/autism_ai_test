import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/video_section/video_section_info_screen.dart';
import 'package:autism_ai_test/uploading/video_storage_class.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/constants/colors.dart';

// Ok, this isn't really a navbar screen, it's more of an info screen before you start the video tasks
// but whatever. This screen gives information about the video tasks and has a button to go to start that whole process

class VideoNavBarScreen extends StatelessWidget {
  final CameraDescription camera;
  const VideoNavBarScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {
    VideoStorageClassItem videoItem = VideoStorageClassItem();
    // This is the main widget that holds the video navbar screen
    // It has an app bar, a body with the text information, and a button to
    // go to the general instructions screen
    return Scaffold(
      backgroundColor: ColorTheme.blueBackground,
      body: Scrollbar(
        thumbVisibility: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorTheme.background,
              border: Border.all(color: ColorTheme.textColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            // This is the body of the screen
            // It has a scrollable column with text information about the video tasks
            // and a button to start the recording
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubTitle(
                    'What are the video tasks?',
                    textAlign: TextAlign.left,
                  ),
                  BodyText(
                    'You will have to complete a series of three tasks, they are: \n',
                    color: ColorTheme.textColor,
                  ),
                  BodyText(
                    '\t\t- ${InstructionAndQuestions.videoNames[0]}',
                    color: ColorTheme.textColor,
                  ),
                  BodyText(
                    '\t\t- ${InstructionAndQuestions.videoNames[1]}',
                    color: ColorTheme.textColor,
                  ),
                  BodyText(
                    '\t\t- ${InstructionAndQuestions.videoNames[2]}',
                    color: ColorTheme.textColor,
                  ),
                  BodyText('', color: ColorTheme.textColor),
                  BodyText(
                    'We really appreciate your time and support!'
                    ' These tasks are quick and simple, and your child might even think they’re just playing with you!\n',
                    color: ColorTheme.textColor,
                  ),
                  BodyText(
                    'This test will roughly take around 1-2 hours or so.  However, you are welcome to leave and come back '
                    'at any time and have your progress saved. We also encourage you to do the tasks out of order '
                    'if that would be easier for your child',
                    color: ColorTheme.textColor,
                  ),
                  BodyText('\n', color: ColorTheme.textColor),
                  NextButton(
                    label: 'START RECORDING',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GeneralInstructionsScreen(
                            camera: camera,
                            videoItem: videoItem,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//EOF home_screen.dart