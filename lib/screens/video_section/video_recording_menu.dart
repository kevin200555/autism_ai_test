import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/other/final_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/uploading/video_storage_class.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:autism_ai_test/widgets/other/video_item.dart';
import 'package:camera/camera.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

// This widget is the menu for the video recording section
// It displays some instructions and a list of the videos the user as to complete
// These videos use th video_item.dart class and are expandable to let the user read their descriptions
// This lets the user choose which videos they want to complete first
// This screen also lets the user upload their videos to firebase, provided they completed all their task
class VideoRecordingMenu extends StatefulWidget {
  final CameraDescription camera;
  final VideoStorageClassItem? videoItem;
  const VideoRecordingMenu({
    super.key,
    required this.camera,
    required this.videoItem,
  });

  @override
  State<VideoRecordingMenu> createState() => _VideoRecordingMenuState();
}

class _VideoRecordingMenuState extends State<VideoRecordingMenu> {
  // This function checks if the video has been recorded
  // It checks if the video path is not empty and contains '/data/'
  bool isVideoRecorded(int videoNumber) {
    final list = widget.videoItem?.recordedVideos;

    if (list == null) return false;
    if (videoNumber < 0 || videoNumber >= list.length) return false;

    final video = list[videoNumber];
    if (video == null) return false;

    // Check if the path contains '/data/'
    final path = video.path;
    if (path.isEmpty) return false; // safety check

    return true;
  }

  // This function submits the videos to firebase
  // It checks if all the videos have been recorded
  // If not, it shows an alert dialog asking the user to complete all tasks
  // If all tasks are completed, it uploads the videos and navigates to the final screen
  submit() async {
    for (int i = 0; i < InstructionAndQuestions.videoNames.length; i++) {
      if (!isVideoRecorded(i)) {
        await showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('please complete all of the tasks'),
          ),
        );
        return;
      }
    }
    widget.videoItem?.getTime();
    widget.videoItem?.printSummary();
    widget.videoItem?.saveToHive();
    widget.videoItem?.uploadAllFiles();
    widget.videoItem?.printSummary();
    if (widget.videoItem != null) {
      UserClass.videoList.add(widget.videoItem!);
    }
    UserClass.currentScreen = "main_menu";
    UserClass.saveToHive();
    widget.videoItem?.resetAll();
    widget.videoItem?.printSummary();
    final box = await Hive.openBox<VideoStorageClassItem>('video_item_box');
    await box.clear();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinalScreen(camera: widget.camera),
      ),
    );
  }

  @override
  // This is the main widget that holds the video recording menu
  // It has an app bar, a body with the instructions and video items, and a
  // next button at the end to submit the videos
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
      body: Scrollbar(
        // This is the body of the screen
        // It has a scrollable list of video items that the user can complete
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SubTitle('Instructions'),
              BodyText(
                'This is the list of all of the videos you have to take. '
                'Carefully read each set of instructions and decide which one you want to do first. '
                'You are welcome to take these out of order.  As always, feel free to take breaks '
                'and continue when you are ready.',
                color: ColorTheme.textColor,
              ),
              BodyText(
                'Click the drop down arrow in order to read the task\'s instructions.'
                'Then scroll down and click the "RECORD" button to complete that task.\n',
                color: ColorTheme.textColor,
              ),
              SubTitle('Tasks'),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorTheme.textColor, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: List.generate(
                      InstructionAndQuestions.videoNames.length,
                      (index) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            VideoItem(
                              camera: widget.camera,
                              labelText:
                                  InstructionAndQuestions.videoNames[index],
                              taskNumber: index,
                              isCompleted: isVideoRecorded(index),
                              onReturnFromRecording: () {
                                setState(() {});
                              },
                              videoItem: widget.videoItem,
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SubTitle('\n'),
              SubTitle('\n'),
              NextButton(
                label: 'SUBMIT VIDEOS',
                onPressed: () {
                  UserClass.currentScreen = "main_menu";
                  submit();
                },
              ),
              BodyText('\n\n\n', color: ColorTheme.textColor),
            ],
          ),
        ),
      ),
    );
  }
} // EOF video_recording_menu.dart
