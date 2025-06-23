import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class GuidedVideoRecording extends StatefulWidget {
  final CameraDescription camera;
  final List<String> instructions;
  const GuidedVideoRecording({
    super.key,
    required this.camera,
    required this.instructions,
  });

  @override
  State<GuidedVideoRecording> createState() => GuidedRecorderState();
}

class GuidedRecorderState extends State<GuidedVideoRecording> {
  int currentStep = 0;
  late CameraController controller;
  bool isRecording = false;
  List<XFile> recordedVideos = [];

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!controller.value.isRecordingVideo) {
      await controller.startVideoRecording();
      setState(() => isRecording = true);
    }
  }

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
            content: const Text('You have completed all recording steps!'),
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
          'Step ${currentStep + 1} of ${widget.instructions.length}',
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
              "Instructions:",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
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
