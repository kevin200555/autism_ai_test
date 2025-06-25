import 'package:flutter/material.dart';
import 'package:autism_ai_test/screens/video_player_screen.dart';

class TestVideoPlayer extends StatelessWidget {
  const TestVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace this with a valid video file path from your device or emulator
    final String testPath = '/storage/emulated/0/Download/COWS_AT_THE_GRASS.mp4';

    return Scaffold(
      appBar: AppBar(title: const Text('Test Video Player')),
      body: VideoPlayerScreen(videoPath: testPath),
    );
  }
}
