/*
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

// This class introduces a widget that displays to the user how far along they are in their test
// It also comes with a some text that shows the % of the test done
class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: ColorTheme.progressBarBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // the progress bar is made up of a bottom rectangle and a top green rectangle stacked on top of it.
          Stack(
            children: [
              // Bottom rectangle
              Container(
                width: MediaQuery.sizeOf(context).width * 0.60,
                height: MediaQuery.sizeOf(context).height * 0.02,
                decoration: BoxDecoration(
                  color: ColorTheme.background,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Top rectangle (shows actual progress)
              Container(
                width:
                    // if user ever somhow gets to 14/13 or something, this makes sure the top rectangle doesn't get any bigger
                    (UserClass.currentScreen / UserClass.totalScreenNumber) >= 1
                    ? MediaQuery.sizeOf(context).width * 0.60
                    : MediaQuery.sizeOf(context).width *
                          0.60 *
                          (UserClass.currentScreen /
                              UserClass.totalScreenNumber),
                height: MediaQuery.sizeOf(context).height * 0.02,
                decoration: BoxDecoration(
                  color:
                      (UserClass.currentScreen / UserClass.totalScreenNumber) <
                          0.25
                      ? ColorTheme.progressBar1
                      : (UserClass.currentScreen / UserClass.totalScreenNumber) <
                            0.50
                      ? ColorTheme.progressBar2
                      : ColorTheme.progressBar3,
                  borderRadius: BorderRadius.circular(
                    10,
                  ), // Adjust the radius as needed
                ),
              ),
            ],
          ),
          // space
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
          // Displays percent of exam completed
          ButtonText(
            // not sure why it decided to format it like this but basically if the user ever accidently
            // somehow gets to 14/13 or something, this makes sure that number stays at 100%
            (100 * (UserClass.currentScreen / UserClass.totalScreenNumber))
                        .toInt() <=
                    100
                ? '${(100 * (UserClass.currentScreen / UserClass.totalScreenNumber)).toInt()}% DONE'
                : '100% DONE',
            maxLines: 1,
          ),
        ],
      ),
    );
  }
} // EOF progress_bar.dart
*/