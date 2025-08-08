import 'dart:io';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/data_gathering/video_player_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';

// Stateful Widget that displays a series of video recording sections that the user must complete
// The user records data for one section, moves on to the next section, and etc
// Unlike the other screens, that are created individually, this generates the screens based on a set of instructions
// these instructions are in the constants folder
// each video has a different set of instuctions, so a different video will be generated for each
// since the instructions can change as I'm given more requirements, this is a must
class VideoRecordingSectionScreen extends StatefulWidget {
  //Takes in the camera from main and the instructions are from home_screen
  final CameraDescription camera;
  final List<String> instructions;
  final int currentStep;
  const VideoRecordingSectionScreen({
    super.key,
    required this.camera,
    required this.instructions,
    required this.currentStep,
  });

  @override
  State<VideoRecordingSectionScreen> createState() => _GuidedRecorderState();
}

class _GuidedRecorderState extends State<VideoRecordingSectionScreen> {
  late int currentStep = widget.currentStep; //keeps track of page
  late CameraController controller;
  //final ScrollController _scrollController = ScrollController();
  bool isRecording = false;
  XFile? recordedVideo; //stores recorded videos

  // This function is for the case where the user saved their progress at video #2 for example, and need to get back
  // to that screen
  // I can't just drop them off at the screen they left at because I didn't code a seperate screen for video #1 and video #2

  // initlize the camera and scroll controllers
  // the camera controllers lets the program interact with the camera (taking and storing videos)
  // the scroll controller makes sure the user always starts at the top of the page before taking a video
  // (so they can read the instructions)
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  //deactivates the recording and scroll
  @override
  void dispose() {
    //_scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  //starts recording
  Future<void> _startRecording() async {
    if (!controller.value.isRecordingVideo) {
      await controller.startVideoRecording();
      debugPrint('recording in progress');
      setState(() => isRecording = true);
    }
  }

  //stops recording, moves onto next section automatically
  Future<void> _stopRecording() async {
    if (controller.value.isRecordingVideo) {
      try {
        final videoFile = await controller.stopVideoRecording();
        debugPrint('Video saved to: ${videoFile.path}');
        //stores recording in the Xfile list
        setState(() {
          isRecording = false;
          recordedVideo = videoFile;
        });
        UserClass.recordedVideos?[currentStep] = recordedVideo;
        UserClass.saveToHive();
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (_) => const AlertDialog(title: Text('Video Saved!')),
        );

        // checks to make sure the video actually stopped recording
      } catch (e) {
        debugPrint('Error stopping video: $e');
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (_) =>
              const AlertDialog(title: Text('Failed to stop recording!')),
        );
      }
    }
  }

  //goes back to previous video screen
  previousVideo() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  //goes to the next video screen
  /*
  nextVideo() async {
    //check to make sure that the user recorded somthing before moving on
    if (!(currentStep >= 0 && currentStep < recordedVideos.length)) {
      await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('please record a video first')),
      );
      return;
    }
    UserClass.recordedVideos?[currentStep] = recordedVideos[currentStep];
    if (currentStep < widget.instructions.length - 1) {
      setState(() {
        currentStep++;
      });
      //goes back to main menu if the current vide step exceeds number of insturcions
    } else {
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
  }
  */

  //deletes Video, has to convert the recordedvideo from an XFILE to a File, This is why this code doesn't work on web applications
  //since web applications can't use dart.io FIles
  Future<void> deleteVideo() async {
    // Assuming currentStep is your index:
    recordedVideo = UserClass.recordedVideos?[currentStep];

    if (recordedVideo != null) {
      final file = File(recordedVideo!.path);

      if (await file.exists()) {
        await file.delete();
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(title: Text('Video Deleted!')),
          
        );
        setState(() {
          UserClass.recordedVideos?[currentStep] = null;
        });

        // Also remove from the list if you want:
        //UserClass.recordedVideos?.removeAt(currentStep);
      } else {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(title: Text('No Video to Delete!')),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(title: Text('No Video to Delete!')),
      );
    }
  }

  //views video, brings user to a seperate screen to do so
  Future<void> viewVideo() async {
    recordedVideo = UserClass.recordedVideos?[currentStep];
    if (recordedVideo == null) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(title: Text('No video to view!')),
      );
      return;
    }
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoPath: recordedVideo!.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      //loading screen, needed since this section has to ask user for camera/mic access first
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Task ${currentStep + 1} of ${widget.instructions.length}: "${InstructionAndQuestions.getVideoNames()[currentStep]}"',
          color: ColorTheme.background,
        ),
        actions: [
          HelpButton(
            color: ColorTheme.alternateTextColor,
            camera: widget.camera,
          ),
        ],
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
        backgroundColor: ColorTheme.accent,
        // This part overrides the default code of the appBar back button
        // This would normally just go back to the previous widget (which is the questionaire secion)
        automaticallyImplyLeading: true,
      ),
      //makes screen scrollable to account for different phone screens
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Instructions'),
            AlternateBodyText(widget.instructions[currentStep], color: ColorTheme.textColor,),
            SubTitle('Recording Section (Scroll Down)'),
            // Text that indicates to the user if they're recording or not, synced with the recording button
            SizedBox(
              width: double.infinity,
              child: AutoSizeText(
                (isRecording) ? 'RECORDING IN PROGRESS' : 'RECORDING STOPPED',
                style: TextStyle(
                  fontSize: 16,
                  color: (isRecording) ? ColorTheme.green : ColorTheme.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                minFontSize: 12,
                maxLines: 1,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // display of the camera
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              child: CameraPreview(controller),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // starts and stops the recording button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // button to let user view their video
                ElevatedButton(
                  onPressed: () {
                    if (!isRecording) {
                      viewVideo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(1), // space inside the button
                    backgroundColor: ColorTheme.background,
                    foregroundColor: ColorTheme.textColor,
                  ),
                  child: const Icon(Icons.remove_red_eye, size: 50),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                //Recording button
                ElevatedButton(
                  onPressed: !controller.value.isInitialized
                      ? null
                      : (isRecording ? _stopRecording : _startRecording),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(1), // space inside the button
                    backgroundColor: (isRecording)
                        ? ColorTheme.green
                        : ColorTheme.red,
                  ),
                  child: isRecording
                      ? Icon(
                          Icons.motion_photos_pause_outlined,
                          size: 72,
                          color: ColorTheme.background,
                        )
                      : Icon(
                          Icons.not_started,
                          size: 72,
                          color: ColorTheme.background,
                        ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                // Lets User delete video if they have a video
                ElevatedButton(
                  onPressed: () {
                    if (!isRecording) {
                      deleteVideo();
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(1), // space inside the button
                    backgroundColor: ColorTheme.background,
                    foregroundColor: ColorTheme.textColor,
                  ),
                  child: const Icon(Icons.delete, size: 50),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            // Next Task/Finish Test
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  color: (UserClass.recordedVideos?[currentStep] == null) ? ColorTheme.progressBarBackground : ColorTheme.green,
                  child: Center(
                    child: ButtonText((UserClass.recordedVideos?[currentStep] == null) ? 'Video not recorded' : 'Task Completed!', maxLines: 1),
                  )
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
} // EOF video_recording_section.dart
