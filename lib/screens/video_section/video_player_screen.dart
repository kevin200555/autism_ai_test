import 'dart:io';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Lets the user view the video they just recorded
// may be a good idea to add a fast forward / rewind button
// (I'll add this later depending on how long the videos end up being)
class VideoPlayerScreen extends StatefulWidget {
  final String videoPath; // Can be file path or network URL

  const VideoPlayerScreen({super.key, required this.videoPath});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 1.1); // grow slightly
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0); // back to normal
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0); // cancel press
  }

  // Initializes the video player controller with the video path
  // This is where the video will be loaded and played
  // The video will automatically play once it is initialized
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {}); // refresh UI once ready
        _controller.play();
      });

    // Listen for video state changes
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // Video ended → force button to show "play"
        setState(() {});
      }
    });
  }

  @override
  // Disposes of the video player controller to free up resources
  // This is important to prevent memory leaks
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  // This is the main widget that holds the video player screen
  // It has an app bar, a body with the video player, and a button to go back
  // The app bar has a title and a help button
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Here is the video you recorded!',
          color: ColorTheme.background,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorTheme.background),
        backgroundColor: ColorTheme.accent,
      ),
      body: Column(
        children: [
          BodyText(
            'Make sure the video fufills all of the requirements detailed in the instructions. '
            'You can always delete and retake the video, so don\'t worry if it takes a few attempts! '
            'Press the back button to exit this screen',
            color: ColorTheme.textColor,
          ),
          Center(
            // shows a loading circle while waiting for everything to load
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
      // play/pause button
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).height * 0.075,
        height: MediaQuery.sizeOf(context).height * 0.075,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
} // EOF video_player_screen.dart
