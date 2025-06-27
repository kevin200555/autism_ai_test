import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/video_player_screen.dart';
import 'package:autism_ai_test/themes/colors.dart';

//Stateful Widget that displays a series of video recording sections that the user must complete
// The user records data for one section, moves on to the next section, and etc
class GuidedVideoRecording extends StatefulWidget {
  //Takes in the camera from main and the instructions are from home_screen
  final CameraDescription camera;
  final List<String> instructions;
  const GuidedVideoRecording({
    super.key,
    required this.camera,
    required this.instructions,
  });

  @override
  State<GuidedVideoRecording> createState() => _GuidedRecorderState();
}

class _GuidedRecorderState extends State<GuidedVideoRecording> {
  int currentStep = 0;
  late CameraController controller;
  bool isRecording = false;
  List<XFile> recordedVideos = [];

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
    print(currentStep);
    if (!(currentStep >= 0 && currentStep < recordedVideos.length)) {
      await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('please record a video first')),
      );
      return;
    }
    if (currentStep < widget.instructions.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      await showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('All Steps Completed! Thank You!')),
      );
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
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
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Video ${currentStep + 1} of ${widget.instructions.length}',
          style: TextStyle(
            color: ColorTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.textColor),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: AutoSizeText(
                textAlign: TextAlign.center,
                'Instructions:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorTheme.alternateTextColor,
                ),
                maxLines: 1,
                minFontSize: 12,
              ),
            ),
            //Displays instructions, these are different across the vidoes
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: AutoSizeText(
                textAlign: TextAlign.center,
                widget.instructions[currentStep],
                style: TextStyle(
                  fontSize: 18,
                  color: ColorTheme.alternateTextColor,
                ),
                maxLines: 10,
                minFontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            AutoSizeText(
              (isRecording) ? 'RECORDING IN PROGRESS' : 'RECORDING STOPPED',
              style: TextStyle(
                fontSize: 12,
                color: ColorTheme.red,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 8,
              maxLines: 1,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              child: CameraPreview(controller),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // starts and stops the recording button
            ElevatedButton(
              onPressed: !controller.value.isInitialized
                  ? null
                  : (isRecording ? _stopRecording : _startRecording),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(1), // space inside the button
                backgroundColor: ColorTheme.primary,
              ),
              child: isRecording
                  ? Icon(
                      Icons.motion_photos_pause_outlined,
                      size: 72,
                      color: ColorTheme.textColor,
                    )
                  : Icon(
                      Icons.not_started,
                      size: 72,
                      color: ColorTheme.textColor,
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
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
                    backgroundColor: ColorTheme.green,
                    foregroundColor: ColorTheme.textColor,
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  SizedBox(height: 12),
                  FloatingActionButton(
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
                    backgroundColor: ColorTheme.red,
                    foregroundColor: ColorTheme.textColor,
                    child: const Icon(Icons.delete),
                  ),
                ],
              ),
              FloatingActionButton(
                onPressed: () {
                  if (!isRecording) {
                    nextVideo();
                  }
                },
                backgroundColor: ColorTheme.primary,
                foregroundColor: ColorTheme.textColor,
                child: const Icon(Icons.arrow_forward_sharp),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
//EOF video_recording_section.dart