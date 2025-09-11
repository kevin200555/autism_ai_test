import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/previous_videos_tile.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

// A screen that displays a list of previous videos recorded by the user
// Each video entry can be expanded to show more details, such as the score
// This screen is useful for users to review their past recordings and performance
class PreviousVideosScreen extends StatelessWidget {
  const PreviousVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the main widget that holds the previous videos screen
    // It has an app bar, a body with a list of previous videos, and each video
    return Scaffold(
      backgroundColor: ColorTheme.blueBackground,
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorTheme.background,
              border: Border.all(color: ColorTheme.textColor, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            // This is the body of the screen
            // It has a scrollable list of previous videos that the user can view
            // Each video is represented by a PreviousVideosTile widget
            child: ListView(
              children: [
                SubTitle('Previous recordings:'),
                BodyText(
                  'Here is a list of your previous recording sessions. '
                  'You can click on each to view more information about them.\n',
                  color: ColorTheme.textColor,
                ),
                // for each video in the user's video list, create a PreviousVideosTile
                // reversing the list to show the most recent first
                ...UserClass.videoList.reversed.map(
                  (video) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: PreviousVideosTile(
                      date: video.date,
                      time: video.time,
                      score: '29',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} // EOF previous_videos_screen.dart
