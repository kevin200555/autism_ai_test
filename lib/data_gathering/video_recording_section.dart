import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/screens/video_player_screen.dart';

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
      setState(() => isRecording = true);
    }
  }

  //stops recording, moves onto next section automatically
  Future<void> _stopRecording() async {
    if (controller.value.isRecordingVideo) {
      final videoFile = await controller.stopVideoRecording();
      setState(() {
        isRecording = false;
        recordedVideos.add(videoFile);
      });
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('Video Saved!')),
      );
    }
  }

  nextVideo() async {
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  previousVideo() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> deleteVideo(String filePath) async {
    if (currentStep >= recordedVideos.length) {
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('No video recorded yet!')),
      );
      return;
    }

    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(title: const Text('Video Deleted')),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(title: const Text('No video to delete!')),
      );
    }
  }

  Future<void> ViewVideo(String filePath) async {
    if (currentStep >= recordedVideos.length) {
      showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: const Text('No video recorded yet!')),
      );
      return;
    }
    final file = File(filePath);
    if (await file.exists()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VideoPlayerScreen(videoPath: recordedVideos[currentStep].path),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(title: const Text('No video to view!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text(
          'Video ${currentStep + 1} of ${widget.instructions.length}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
        automaticallyImplyLeading: false, // Prevents the default back button
        leading: IconButton(
          // Your custom leading widget
          icon: Icon(Icons.arrow_back), // The desired icon
          onPressed: previousVideo,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Instructions:',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          //Displays instructions, these are different across different surveys
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              textAlign: TextAlign.center,
              widget.instructions[currentStep],
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Expanded(child: CameraPreview(controller)),
          ),
          const SizedBox(height: 12),

          //starts/stops the recording button
          ElevatedButton(
            onPressed: !controller.value.isInitialized ? null : (isRecording ? _stopRecording : _startRecording),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(1), // space inside the button
              backgroundColor: const Color.fromARGB(255, 1, 51, 93),
            ),
            child: isRecording
                ? Icon(
                    Icons.motion_photos_pause_outlined,
                    size: 48,
                    color: Colors.white,
                  )
                : Icon(Icons.not_started, size: 96, color: Colors.white),
          ),
        ],
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
                      ViewVideo(recordedVideos[currentStep].path);
                    },
                    backgroundColor: const Color.fromARGB(255, 95, 230, 64),
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  SizedBox(height: 12),
                  FloatingActionButton(
                    onPressed: () {
                      deleteVideo(recordedVideos[currentStep].path);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.delete),
                  ),
                ],
              ),
              FloatingActionButton(
                onPressed: nextVideo,
                backgroundColor: const Color.fromARGB(255, 1, 51, 93),
                foregroundColor: Colors.white,
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