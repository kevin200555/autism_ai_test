import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blueGrey,
      child: Row(
        children: [
          Stack(
            children: [
              // Bottom rectangle
              Container(width: MediaQuery.sizeOf(context).width * 0.7, height: MediaQuery.sizeOf(context).width * 0.05, color: ColorTheme.background),

              // Top rectangle (smaller and positioned)
              Container(width: MediaQuery.sizeOf(context).width * 0.3, height: MediaQuery.sizeOf(context).width * 0.05, color: ColorTheme.green),
            ],
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05,),
          Text(
            '${UserClass.screenNumber}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
