import 'package:autism_ai_test/constants/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatelessWidget {
  final CameraDescription camera;
  const VideoScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check out the \'video\' tab in order to start a recording section!\n',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ColorTheme.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
