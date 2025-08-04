import 'dart:io';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Lets the user view the video they just recorded
// may be a good idea to add a fast forward/rewind button
class VideoPlayerScreen extends StatefulWidget {
  final String videoPath; // Can be file path or network URL

  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle('Video Playback', color: ColorTheme.background),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.background),
        backgroundColor: ColorTheme.accent,
      ),
      body: Center(
        // shows a loading circle while waiting for everything to load
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      // play/pause button
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).height * 0.075,
        height: MediaQuery.sizeOf(context).height * 0.075,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          shape: const CircleBorder(),
          backgroundColor: ColorTheme.accent,
          foregroundColor: ColorTheme.background,
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            size: MediaQuery.sizeOf(context).height * 0.07,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
} // EOF video_player_screen.dart
