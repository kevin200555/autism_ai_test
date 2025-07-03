// This is section is actually a series of pages linked together
// They are connected by swipping and this is done in order to make the instructions
// easier to digest

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/video_recording_section_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoSectionInfoScreen extends StatelessWidget {
  final CameraDescription camera;
  final PageController _pageController = PageController(initialPage: 0);

  VideoSectionInfoScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        GeneralInstructionsScreen(camera: camera),
        VideoSectionInfoScreen2(camera: camera),
        VideoSectionInfoScreen3(camera: camera),
        VideoSectionInfoScreen4(camera: camera),
      ],
    );
  }
}

class GeneralInstructionsScreen extends StatelessWidget {
  final CameraDescription camera;
  const GeneralInstructionsScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Video Section Information Page 1 of 4',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('General Instructions'),
            RichBodyText(
              TextSpan(
                children: [
                  TextSpan(text: 'You\'ll be recording '),
                  TextSpan(
                    text: '3 short tasks',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' using your phone. Each task should be recorded as a',
                  ),
                  TextSpan(
                    text: ' separate video.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' You can upload the videos directly through the app when you\'re done.\n',
                  ),
                ],
              ),
            ),
            SubTitle('Here are a few tips before you start:'),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- Make sure your child\'s '),
                    TextSpan(
                      text: 'face is not covered ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: '(no hats or sunglasses).'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- Try to record in a '),
                    TextSpan(
                      text: 'quiet',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'place—turn off the TV or music.'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- '),
                    TextSpan(
                      text: 'Good lighting',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' is important! Daytime is best so we can clearly see your child\'s face and body.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'It\'s okay if you\'re in the video too—we want to see how your child interacts with you.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- '),
                    TextSpan(
                      text: 'There\'s no right or wrong response.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' Even if your child doesn\'t respond at all,'
                          'that\'s totally fine. Every video helps our research.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- You don’t have to finish everything at once. Feel free to',
                    ),
                    TextSpan(
                      text: 'take breaks or spread the tasks out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' over a few days.'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- You’ll find the task instructions on the next page. Please read each one before recording\n',
                    ),
                  ],
                ),
              ),
            ),
            BodyText('Thanks again for being part of this—we\'re excited to see what you and your child share with us!\n'),
            SubTitle('Swipe Right on your phone to continue reading>>>>', style: TextStyle(color: ColorTheme.red))
          ],
        ),
      ),
    );
  }
}

class VideoSectionInfoScreen2 extends StatelessWidget {
  final CameraDescription camera;
  const VideoSectionInfoScreen2({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Video Section Information Page 2 of 4',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: false,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Setup'),
            BodyText(
              'Make sure your child is not wearing sunglasses or a hat that would obstruct his/her face.\n',
            ),
            BodyText(
              'Please ensure there is no background noise to distract your child (turn off any TV, music, etc)\n',
            ),
            BodyText(
              'Ensure your phone\'s video camera to its highest quality setting with no compression.\n',
            ),
            BodyText(
              'Please use the camera stand included with your package. The phone should be placed '
              'horizontally (landscape) in the stand using the rear facing (not selfie) camera to record\n',
            ),
            BodyText(
              '(the front facing camera is usually lower quality and could also distract your child.)',
            ),
            Image(image: AssetImage('assets/camera_placement_example.png')),
            SubTitle('\nSWIPE>>>'),
          ],
        ),
      ),
    );
  }
}

class VideoSectionInfoScreen3 extends StatelessWidget {
  final CameraDescription camera;
  const VideoSectionInfoScreen3({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Video Section Information Page 3 of 4',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: false,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Setup (Continued)'),
            BodyText(
              'For ease of recording, you could ask a third person to help you record, but please be careful'
              'this person doesn\'t distract your child with their presence. (But it\'s fine if there\'s a delay'
              ' between starting the video and walking to the other sideof the room).\n',
            ),
            BodyText(
              'Make sure the camera is positioned far enough away that your child\'s full face and body is visible '
              'during filming. The parent who interacts with child should also be visible during each recorded task.\n',
            ),
            BodyText(
              'Please record videos in the daytime when the lighting is sufficient to ensure that the face'
              'can be clearly seen in the videos. A clear face and body can help us develop better detection models.\n',
            ),
            BodyText(
              'There is no right or wrong answer, just record whatever your child\'s response and actions,'
              ' even if s/he never responds; this is still very valuable information! Please record the entire interaction.\n',
            ),
            BodyText(
              'You do NOT have to do all tasks at once. Take breaks or record on separate'
              'days if your child gets tired or loses interest.\n',
            ),
            BodyText(
              'Make sure to enable your camera and microphone when prompted.\n',
            ),
            SubTitle('SWIPE>>>'),
          ],
        ),
      ),
    );
  }
}

class VideoSectionInfoScreen4 extends StatefulWidget {
  final CameraDescription camera;
  const VideoSectionInfoScreen4({super.key, required this.camera});

  @override
  State<VideoSectionInfoScreen4> createState() =>
      _VideoSectionInfoScreen4State();
}

class _VideoSectionInfoScreen4State extends State<VideoSectionInfoScreen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'Video Section Information Page 4 of 4',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: false,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Task Instructions'),
            BodyText(
              'Read through each task before recording it to ensure you have the right props and know how to respond.\n',
            ),
            BodyText(
              'Please try to follow each procedure exactly. (e.g. Don\'t call your child\'s name or repeat'
              ' phrases more than what is described in the task.) \n',
            ),
            BodyText(
              'If you are asked to say a sentence, for example, "Bring me the bear", then please'
              'speak the exact same sentence (this will help us design a cool audio detection tool!).\n',
            ),
            BodyText(
              'After you complete the verbal portion of each task, please continue to record your child'
              '(and interact with them) for at least 30 seconds more before stopping each recording.'
              '(Note task 7 is a little different).\n\n\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            BodyText(
              'When you are ready to begin the test, click the below button\n',
            ),
            NextButton(
              label: 'BEGIN TEST',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoRecordingSectionScreen(
                      camera: widget.camera,
                      instructions:
                          InstructionAndQuestions.getVideoInstructios(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
