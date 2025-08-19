import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// This module is used in the video recording menu
// It is a expandable tile.  So it appears as a box of text at first, then expands into more information when clicked
// It is used to diaply to the user the task they have to complete and if they have completed them
class FormTile extends StatefulWidget {
  // These parameters are in order to make these tiles dynamically
  // Tiles are esstienally the same, they just have different text depending on the task number
  final CameraDescription camera;
  final String labelText;
  final String description;
  final bool isCompleted;
  final VoidCallback? onReturnFromRecording;
  final Widget asscoiatedScreen;

  const FormTile({
    super.key,
    required this.camera,
    required this.labelText,
    required this.isCompleted,
    this.onReturnFromRecording,
    required this.description,
    required this.asscoiatedScreen,
  });

  @override
  State<FormTile> createState() => _FormTileState();
}

class _FormTileState extends State<FormTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        border: Border.all(color: ColorTheme.textColor, width: 2), // Border
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: ColorTheme.textColor),
          child: ExpansionTile(
            title: Text(
              (widget.isCompleted)
                  ? '${widget.labelText} (Completed!)'
                  : '${widget.labelText} (In Progress)',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            collapsedTextColor: (widget.isCompleted)
                ? ColorTheme.background
                : ColorTheme.textColor,
            textColor: (widget.isCompleted)
                ? ColorTheme.background
                : ColorTheme.textColor,
            collapsedBackgroundColor: (widget.isCompleted)
                ? ColorTheme.green
                : ColorTheme.primary,
            backgroundColor: (widget.isCompleted)
                ? ColorTheme.green
                : ColorTheme.background,
            collapsedIconColor: ColorTheme.textColor,
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
                      widget.description,
                      color: (widget.isCompleted)
                          ? ColorTheme.background
                          : ColorTheme.textColor,
                    ),
                    // Takes user to the place where they'll record their video
                    (UserClass.formCompleted(UserClass.iCResponses) &&
                            widget.labelText ==
                                'Informed Consent Document Form')
                        ? NextButton(
                            label: 'Sorry, you cannot edit this form',
                            onPressed: () {},
                          )
                        : NextButton(
                            label: (widget.isCompleted)
                                ? 'EDIT/VIEW FORM'
                                : 'TAKE FORM',
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget.asscoiatedScreen,
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
