import 'dart:io';

import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/information_screens/final_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:autism_ai_test/widgets/other/video_item.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecordingMenu extends StatefulWidget {
  final CameraDescription camera;
  const VideoRecordingMenu({super.key, required this.camera});

  @override
  State<VideoRecordingMenu> createState() => _VideoRecordingMenuState();
}

class _VideoRecordingMenuState extends State<VideoRecordingMenu> {
  bool isVideoRecorded(int videoNumber) {
    final list = UserClass.recordedVideos;
    if (list == null) return false;
    if (videoNumber < 0 || videoNumber >= list.length) return false;
    return list[videoNumber] != null;
  }

  submit() async {
    for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
      if (!isVideoRecorded(i)) {
        await showDialog(
          context: context,
          builder: (_) =>
              const AlertDialog(title: Text('please record a video first')),
        );
        return;
      }
    }

    File userReport = await UserClass.writeToReportFile(
      UserClass.generateUserReport(),
    );
    
    UserClass.uploadAllFiles(userReport);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalScreen(camera: widget.camera),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          HelpButton(
            color: ColorTheme.alternateTextColor,
            camera: widget.camera,
          ),
        ],
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
              'Click the drop down arrow in order to read the task\'s instructions.'
              'Then scroll down and click the "RECORD" button to complete that task.\n',
              maxLines: 4,
            ),
            SubTitle('Tasks'),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: Column(
                children: List.generate(
                  InstructionAndQuestions.videoNames.length,
                  (index) {
                    return VideoItem(
                      camera: widget.camera,
                      labelText: InstructionAndQuestions.videoNames[index],
                      taskNumber: index,
                      isCompleted: isVideoRecorded(index),
                      onReturnFromRecording: () {
                        setState(() {}); // Refresh UI after returning from recording
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            NextButton(label: 'SUBMIT VIDEOS', onPressed: (){
              submit();
            })
          ],
        ),
      ),
    );
  }
}
