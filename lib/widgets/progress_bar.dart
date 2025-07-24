import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:flutter/material.dart';

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
                width: MediaQuery.sizeOf(context).width * 0.65 * (UserClass.screenNumber/UserClass.totalScreenNumber),
                height: MediaQuery.sizeOf(context).height * 0.02,
                color: ColorTheme.green,
              ),
            ],
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
          Text(
            //'${UserClass.screenNumber}',
            '${(100*(UserClass.screenNumber/UserClass.totalScreenNumber)).toInt()}% Done',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
