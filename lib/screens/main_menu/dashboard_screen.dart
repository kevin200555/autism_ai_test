import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/score.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(2),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // background color
                    border: Border.all(
                      color: ColorTheme.textColor, // border color
                      width: 3, // border width
                    ),
                    borderRadius: BorderRadius.circular(
                      4,
                    ), // optional: rounded corners
                  ),
                  child: Text(
                    'Hello,\n${UserClass.childIntakeResponses?[0]}!',
                    style: TextStyle(
                      fontSize: 30,
                      color: ColorTheme.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // background color
                    border: Border.all(
                      color: ColorTheme.textColor, // border color
                      width: 3, // border width
                    ),
                    borderRadius: BorderRadius.circular(
                      4,
                    ), // optional: rounded corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previous Test Result: \nDate: 08/04/2024\n',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PartialCircle(
                        fraction: 0.9,
                        size: 150,
                        color: ColorTheme.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
