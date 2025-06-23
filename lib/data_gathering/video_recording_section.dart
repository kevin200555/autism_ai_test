import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Video Saved!')));

      if (currentStep < widget.instructions.length - 1) {
        setState(() => currentStep++);
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('All Done'),
            content: const Text('Thank you for completing all of the steps! Your responses have been recorded'),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video ${currentStep + 1} of ${widget.instructions.length}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Instructions:',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          //Displays instructions, these are different across different surveys
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              textAlign: TextAlign.center,
              widget.instructions[currentStep],
              style: const TextStyle(fontSize: 20),
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
            onPressed: isRecording ? _stopRecording : _startRecording,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(1), // space inside the button
              backgroundColor: const Color.fromARGB(255, 176, 220, 255),
            ),
            child: isRecording
                ? Icon(
                    Icons.motion_photos_pause_outlined,
                    size: 96,
                    color: Colors.white,
                  )
                : Icon(Icons.not_started, size: 96, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
//EOF video_recording_section.dart