import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/video_section/video_section_info_screen.dart';
import 'package:autism_ai_test/uploading/video_storage_class.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// The purpose of this class is to ease the user back in after they disconnected from a video session
class DisconnectScreen extends StatefulWidget {
  final CameraDescription camera;
  const DisconnectScreen({super.key, required this.camera});

  @override
  State<DisconnectScreen> createState() => _DisconnectScreenState();
}

class _DisconnectScreenState extends State<DisconnectScreen> {
  VideoStorageClassItem? videoItem;

  // This function loads the video item from the storage class
  // It is called in the initState to ensure the video item is loaded before the screen
  @override
  void initState() {
    super.initState();
    _loadVideoItem();
  }

  // This function loads the video item from the storage class
  // It is used to ensure that the video item is available when the screen is built
  Future<void> _loadVideoItem() async {
    final item = await VideoStorageClassItem.loadFromHive();
    setState(() {
      videoItem = item;
    });
  }

  @override
  // This is the main widget that holds the disconnect screen
  // It has an app bar, a body with the text information, and a button to
  // go to the general instructions screen
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ImportantBodyText(
            'Hey it seemed like you disconnected during your last video recording session '
            'No worries! Your progress was saved and feel free to continue where you left off\n',
            color: ColorTheme.textColor,
          ),
          NextButton(
            label: 'Next',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneralInstructionsScreen(
                    camera: widget.camera,
                    videoItem: videoItem,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} // EOF disconnect_screen.dart
