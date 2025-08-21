import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/previous_videos_tile.dart';
import 'package:flutter/material.dart';

class PreviousVideosScreen extends StatelessWidget {
  const PreviousVideosScreen({super.key});

  // Sample list of video data


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: UserClass.videoList.length,
        itemBuilder: (context, index) {
          final video = UserClass.videoList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PreviousVideosTile(
              date: video.date,
              time: video.time,
              score: '47',
            ),
          );
        },
      ),
    );
  }
}
