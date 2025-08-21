import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/video_section/video_recording_section_screen.dart';
import 'package:autism_ai_test/uploading/video_storage_class.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This module is used in the video recording menu
// It is a expandable tile.  So it appears as a box of text at first, then expands into more information when clicked
// It is used to diaply to the user the task they have to complete and if they have completed them
class VideoItem extends StatefulWidget {
  // These parameters are in order to make these tiles dynamically
  // Tiles are esstienally the same, they just have different text depending on the task number
  final CameraDescription camera;
  final String labelText;
  final int taskNumber;
  final bool isCompleted;
  final VoidCallback? onReturnFromRecording;
  final VideoStorageClassItem? videoItem;

  const VideoItem({
    super.key,
    required this.camera,
    required this.labelText,
    required this.taskNumber,
    required this.isCompleted,
    this.onReturnFromRecording,
    required this.videoItem,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border.all(color: ColorTheme.textColor, width: 2), // Border
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: ColorTheme.textColor),
          child: ExpansionTile(
            // ExpansionTile has multiple parameters based on whether or not the tile is collapsed or not
            // when video is not completed and tile is collasped, it is grey with white text
            // when video is not completed and tile is expanded, it is white with black text
            // when video is completed and tile is collasped, it is green with white text
            // when video is completed and tile is expanded, it is green with white text
            title: Text(
              (widget.isCompleted)
                  ? '${widget.taskNumber + 1}: ${widget.labelText} (Completed!)'
                  : '${widget.taskNumber + 1}: ${widget.labelText} (In Progress)',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            collapsedTextColor: ColorTheme.background,
            textColor: (widget.isCompleted)
                ? ColorTheme.background
                : ColorTheme.textColor,
            collapsedBackgroundColor: (widget.isCompleted)
                ? ColorTheme.green
                : ColorTheme.progressBarBackground,
            backgroundColor: (widget.isCompleted)
                ? ColorTheme.green
                : ColorTheme.background,
            collapsedIconColor: ColorTheme.background,
            iconColor: (widget.isCompleted)
                ? ColorTheme.background
                : ColorTheme.textColor,
            // This is what is in the expanded tile information, it displays the task instructions
            // This is so that the user can read which instruction they want to do first before going to the recording screen
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    BodyText(
                      'Task #${widget.taskNumber + 1} Instructions\n',
                      color: (widget.isCompleted)
                          ? ColorTheme.background
                          : ColorTheme.textColor,
                    ),
                    BodyText(
                      InstructionAndQuestions.videoInstructions[widget
                          .taskNumber],
                      color: (widget.isCompleted)
                          ? ColorTheme.background
                          : ColorTheme.textColor,
                    ),
                    // Takes user to the place where they'll record their video
                    NextButton(
                      label: 'RECORD',
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoRecordingSectionScreen(
                              camera: widget.camera,
                              instructions:
                                  InstructionAndQuestions.videoInstructions,
                              currentStep: widget.taskNumber,
                              videoItem: widget.videoItem,
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
          ),
        ),
      ),
    );
  }
} // EOF video_item.dart
