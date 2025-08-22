import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/previous_videos_tile.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

class PreviousVideosScreen extends StatelessWidget {
  const PreviousVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Your text at the top
            SubTitle('Previous recordings:'),
            BodyText(
              'Here is a list of your previous recording sessions. '
              'You can click on each to view more information about them.\n',
              color: ColorTheme.textColor,
            ),

            // Now your list of tiles
            ...UserClass.videoList.map(
              (video) => Padding(
                padding: EdgeInsets.fromLTRB(16,4,16,4),
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
    );
  }
}
