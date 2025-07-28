import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';

// This class introduces a widget that displays to the user how far along they are in their test
//
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
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // the progress bar is made up of a bottom rectangle and a top green rectangle stacked on top of it.
          Stack(
            children: [
              // Bottom rectangle
              Container(
                width: MediaQuery.sizeOf(context).width * 0.65,
                height: MediaQuery.sizeOf(context).height * 0.02,
                color: ColorTheme.background,
              ),

              // Top rectangle (shows actual progress)
              Container(
                width:
                    // if user ever somhow gets to 14/13 or something, this makes sure the top rectangle doesn't get any bigger
                    (UserClass.screenNumber / UserClass.totalScreenNumber) >= 1
                    ? MediaQuery.sizeOf(context).width * 0.65
                    : MediaQuery.sizeOf(context).width *
                          0.65 *
                          (UserClass.screenNumber /
                              UserClass.totalScreenNumber),
                height: MediaQuery.sizeOf(context).height * 0.02,
                color:
                    (UserClass.screenNumber / UserClass.totalScreenNumber) <
                        0.333
                    ? ColorTheme.progressBar1
                    : (UserClass.screenNumber / UserClass.totalScreenNumber) <
                          0.666
                    ? ColorTheme.progressBar2
                    : ColorTheme.progressBar3,
              ),
            ],
          ),
          // space
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
          // Displays percent of exam completed
          ButtonText(
            // not sure why it decided to format it like this but basically if the user ever accidently
            // somehow gets to 14/13 or something, this makes sure that number stays at 100%
            (100 * (UserClass.screenNumber / UserClass.totalScreenNumber))
                        .toInt() <=
                    100
                ? '${(100 * (UserClass.screenNumber / UserClass.totalScreenNumber)).toInt()}% DONE'
                : '100% DONE',
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
