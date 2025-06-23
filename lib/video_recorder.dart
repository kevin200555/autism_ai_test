import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class VideoRecorder extends StatefulWidget {
  final CameraDescription camera;
  const VideoRecorder({Key? key, required this.camera}) : super(key: key);

  @override
  _VideoRecorderState createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder> {
  late CameraController _controller;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isRecordingVideo) {
      await _controller.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  Future<void> _stopRecording() async {
    if (_controller.value.isRecordingVideo) {
      final XFile videoFile = await _controller.stopVideoRecording();
      setState(() => _isRecording = false);
      print('Video saved to ${videoFile.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Video Recorder')),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: CameraPreview(_controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
