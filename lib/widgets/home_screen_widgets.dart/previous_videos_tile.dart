import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/score.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

/// A tile that displays previous video information
/// It includes the date, time, and score of the video
/// The tile can be expanded to show more details
/// This widget is used in the PreviousVideosScreen
class PreviousVideosTile extends StatefulWidget {
  final String date;
  final String time;
  final String score;
  const PreviousVideosTile({
    super.key,
    required this.date,
    required this.time,
    required this.score,
  });

  @override
  State<PreviousVideosTile> createState() => _PreviousVideosTileState();
}

class _PreviousVideosTileState extends State<PreviousVideosTile> {
  @override
  Widget build(BuildContext context) {
    return 
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: ColorTheme.textColor),
          child: ExpansionTile(
            title: SubTitle('${widget.date} at ${widget.time}'),
            collapsedTextColor: ColorTheme.textColor,
            textColor: ColorTheme.textColor,
            collapsedBackgroundColor: ColorTheme.primary,
            backgroundColor: ColorTheme.background,
            collapsedIconColor: ColorTheme.textColor,
            iconColor: ColorTheme.textColor,
            // This is what is in the expanded tile information, it displays the task instructions

            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    PartialCircle(fraction:  int.parse(widget.score)/100, size: 100, color: ColorTheme.green,)
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
} // EOF previous_videos_tile.dart
