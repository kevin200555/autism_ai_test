import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  final CameraDescription camera;
  final String labelText;
  final int taskNumber;
  final bool isCompleted;

  const VideoItem({
    super.key,
    required this.camera,
    required this.labelText,
    required this.taskNumber,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ButtonText((isCompleted) ? '${taskNumber + 1}: $labelText (Completed!)' : '${taskNumber + 1}: $labelText (In Progress)', maxLines: 1),
      collapsedBackgroundColor: (isCompleted) ? ColorTheme.green : ColorTheme.progressBarBackground,
      backgroundColor: ColorTheme.background,
      collapsedIconColor: ColorTheme.background,
      iconColor: ColorTheme.textColor,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SubTitle('Task #${taskNumber + 1} Instructions'),
              BodyText(
                InstructionAndQuestions.videoInstructions[taskNumber],
                maxLines: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
