import 'dart:io';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/information_screens/final_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/data_gathering/video_player_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';

//Stateful Widget that displays a series of video recording sections that the user must complete
// The user records data for one section, moves on to the next section, and etc
class VideoRecordingSectionScreen extends StatefulWidget {
  //Takes in the camera from main and the instructions are from home_screen
  final CameraDescription camera;
  final List<String> instructions;
  const VideoRecordingSectionScreen({
    super.key,
    required this.camera,
    required this.instructions,
  });

  @override
  State<VideoRecordingSectionScreen> createState() => _GuidedRecorderState();
}

class _GuidedRecorderState extends State<VideoRecordingSectionScreen> {
  int currentStep = 0; //keeps track of page
  late CameraController controller;
  bool isRecording = false;
  List<XFile> recordedVideos = []; //stores recorded videos

  //initlize the camera controller
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  //deactivates the recording
  @override
  void dispose() {
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
          if (recordedVideos.length > currentStep) {
            recordedVideos[currentStep] = videoFile;
          } else {
            recordedVideos.add(videoFile);
          }
        });

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

  //goes to the next video
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
    UserClass.printSummary();
    if (currentStep < widget.instructions.length - 1) {
      setState(() {
        currentStep++;
      });
      //goes back to main menu
    } else {
      File userReport = await UserClass.writeToReportFile(UserClass.generateUserReport());
      UserClass.uploadAllFiles(userReport);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FinalScreen()),
      );
    }
  }

  //goes back to previous video
  previousVideo() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  //deletes Video, has to convert the recordedvideo from an XFILE to a File, This is why this code doesn't work on web applications
  //since web applications can't use dart.io FIles
  Future<void> deleteVideo(int index) async {
    final filePath = recordedVideos[index].path;
    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
      setState(() => recordedVideos.removeAt(index));
      if (mounted) {
        await showDialog(
          context: context,
          builder: (_) => const AlertDialog(title: Text('Video deleted!')),
        );
      }
    } else {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (_) => const AlertDialog(title: Text('No Video to Delete.')),
        );
      }
    }
  }

  //views video,
  Future<void> viewVideo(XFile videoFile) async {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoPath: videoFile.path),
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
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
        backgroundColor: ColorTheme.accent,
        // This part overrides the default code of the appBar back button
        // This would normally just go back to the previous widget (which is the questionaire secion)
        automaticallyImplyLeading: false,
        leading: IconButton(
          // Your custom leading widget
          icon: Icon(Icons.arrow_back), // The desired icon
          onPressed: () {
            if (!isRecording) {
              previousVideo();
            }
          },
        ),
      ),
      //makes screen scrollable to account for different phone screens
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Instructions'),
            BodyText(widget.instructions[currentStep], maxLines: 40),
            BodyText('', maxLines: 1),
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
                      if (currentStep < recordedVideos.length) {
                        viewVideo(recordedVideos[currentStep]);
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('No video to view!'),
                          ),
                        );
                      }
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
                      if (currentStep < recordedVideos.length) {
                        deleteVideo(currentStep);
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('No video to delete!'),
                          ),
                        );
                      }
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
            NextButton(
              label:
                  (currentStep ==
                      widget.instructions.length -
                          1) // if on last step, change text to show the user is abou tto complete the test
                  ? 'FINISH'
                  : 'SUBMIT VIDEO',
              onPressed: () {
                if (!isRecording) {
                  nextVideo();
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
} // EOF video_recording_section.dart
