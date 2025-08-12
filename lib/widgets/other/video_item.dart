import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/video_recording_section_screen.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoItem extends StatefulWidget {
  final CameraDescription camera;
  final String labelText;
  final int taskNumber;
  final bool isCompleted;
  final VoidCallback? onReturnFromRecording;

  const VideoItem({
    super.key,
    required this.camera,
    required this.labelText,
    required this.taskNumber,
    required this.isCompleted,
    this.onReturnFromRecording,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ButtonText(
        (widget.isCompleted)
            ? '${widget.taskNumber + 1}: ${widget.labelText} (Completed!)'
            : '${widget.taskNumber + 1}: ${widget.labelText} (In Progress)',
        maxLines: 1,
      ),
      collapsedBackgroundColor: (widget.isCompleted)
          ? ColorTheme.green
          : ColorTheme.progressBarBackground,
      backgroundColor: (widget.isCompleted)
          ? ColorTheme.green
          : ColorTheme.background,
      collapsedIconColor: ColorTheme.background,
      iconColor: ColorTheme.textColor,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BodyText('Task #${widget.taskNumber + 1} Instructions\n',color: (widget.isCompleted)
                    ? ColorTheme.background
                    : ColorTheme.textColor),
              BodyText(
                InstructionAndQuestions.videoInstructions[widget.taskNumber],
                color: (widget.isCompleted)
                    ? ColorTheme.background
                    : ColorTheme.textColor,
              ),
              NextButton(
                label: 'RECORD',
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoRecordingSectionScreen(
                        camera: widget.camera,
                        instructions: InstructionAndQuestions.videoInstructions,
                        currentStep: widget.taskNumber,
                      ),
                    ),
                  );
                  widget.onReturnFromRecording?.call();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
