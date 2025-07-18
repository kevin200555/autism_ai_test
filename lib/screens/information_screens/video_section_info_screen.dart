// This is section is actually a series of pages linked together
// They are connected by swipping and this is done in order to make the instructions
// easier to digest

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/video_recording_section_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/*
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
        FewTipsBeforeStart(camera: camera),
        BeforeYouStartScreen(camera: camera),
        FilmingTipsScreen(camera: camera),
      ],
    );
  }
}
*/

class GeneralInstructionsScreen extends StatelessWidget {
  final CameraDescription camera;
  const GeneralInstructionsScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Video Section Information Page 1 of 4',
          color: ColorTheme.textColor,
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
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  TextSpan(
                    text:
                        ' using your phone. Each task should be recorded as a',
                  ),
                  TextSpan(
                    text: ' separate video.',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' You can upload the videos directly through the app when you\'re done.\n',
                  ),
                ],
              ),
              maxLines: 5,
            ),
            NextButton(
              label: 'NEXT',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FewTipsBeforeStart(camera: camera),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class FewTipsBeforeStart extends StatelessWidget {
  final CameraDescription camera;
  const FewTipsBeforeStart({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Video Section Information Page 2 of 4',
          color: ColorTheme.textColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: true,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Here are a few tips before you start:'),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- Make sure your child\'s '),
                    TextSpan(
                      text: 'face is not covered ',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '(no hats or sunglasses).\n'),
                  ],
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- Try to record in a '),
                    TextSpan(
                      text: 'quiet ',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'place—turn off the TV or music.'),
                  ],
                ),
                maxLines: 2,
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
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' is important! Daytime is best so we can clearly see your child\'s face and body.\n',
                    ),
                  ],
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- It\'s okay if you\'re in the video too—we want to see how your child interacts with you.\n',
                    ),
                  ],
                ),
                maxLines: 3,
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
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' Even if your child doesn\'t respond at all,'
                          ' that\'s totally fine. Every video helps our research.\n',
                    ),
                  ],
                ),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- You don\'t have to finish everything at once. Feel free to',
                    ),
                    TextSpan(
                      text: ' take breaks or spread the tasks out',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' over a few days.\n'),
                  ],
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- You\'ll find the task instructions on the next page.',
                    ),
                    TextSpan(
                      text: ' Please read each one before recording.\n',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                maxLines: 3,
              ),
            ),
            BodyText(
              'Thanks again for being part of this—we\'re excited to see what you and your child share with us!\n',
              maxLines: 4,
            ),
            NextButton(
              label: 'NEXT',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BeforeYouStartScreen(camera: camera),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class BeforeYouStartScreen extends StatelessWidget {
  final CameraDescription camera;
  const BeforeYouStartScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Video Section Information Page 3 of 4',
          color: ColorTheme.textColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: true,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Before You Start'),
            BodyText(
              'Please read through all three tasks before recording. This will help you prepare '
              'the right items and understand what to say or do during each activity.\n',
              maxLines: 4,
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- Try to follow the steps'),
                    TextSpan(
                      text: ' exactly as written,',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          ' especially when calling your child\'s name or saying a'
                          'specific sentence (e.g., “Bring me the toy”). Using the',
                    ),
                    TextSpan(
                      text: ' exact wording ',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          'helps us build useful tools like audio-based detection systems.\n',
                    ),
                  ],
                ),
                maxLines: 6,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- If a sentence is included in quotation marks, please say',
                    ),
                    TextSpan(
                      text: ' that exact sentence only once,',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(text: ' as instructed in the task.\n'),
                  ],
                ),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '- After you finish the main prompt or question in each task,',
                    ),
                    TextSpan(
                      text: ' keep recording for at least 30 seconds',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text: ' or until the interaction ends naturally.\n',
                    ),
                  ],
                ),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(text: '- Make sure your child\'s'),
                    TextSpan(
                      text: ' face and body',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          ' are visible as much as possible throughout the video.\n',
                    ),
                  ],
                ),
                maxLines: 3,
              ),
            ),
            BodyText(
              'There are 3 tasks in total. They are meant to feel like playful,'
              ' everyday moments—so please keep it relaxed and natural.\n',
              maxLines: 4,
            ),
            NextButton(
              label: 'NEXT',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FilmingTipsScreen(camera: camera),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class FilmingTipsScreen extends StatefulWidget {
  final CameraDescription camera;
  const FilmingTipsScreen({super.key, required this.camera});

  @override
  State<FilmingTipsScreen> createState() => _FilmingTipsScreenState();
}

class _FilmingTipsScreenState extends State<FilmingTipsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Video Section Information Page 4 of 4',
          color: ColorTheme.textColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: true,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Filming Tips'),
            RichBodyText(
              TextSpan(
                children: [
                  TextSpan(text: 'Try to keep your child\'s'),
                  TextSpan(
                    text: ' full body and face ',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  TextSpan(
                    text:
                        'visible in the video whenever possible. You can choose one of'
                        'the following ways to record, based on what works best for your situation:\n',
                  ),
                ],
              ),
              maxLines: 4,
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '- Hold the phone yourself',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          ' (recommended if possible): If filming alone, you can hold the phone'
                          ' casually during the task—just try to be natural and avoid making the '
                          'child feel like they are being “watched.”\n',
                    ),
                  ],
                ),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '- Place the phone on a stable surface:',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          ' If your hands are needed for part of the task (e.g., using a'
                          ' spoon), you can briefly place the phone somewhere steady. '
                          'Just make sure the angle captures your child\'s body and face.\n',
                    ),
                  ],
                ),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 0, 0, 0),
              child: RichBodyText(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '- Have a second person film:',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          ' This helps you focus on interacting with your child while someone else'
                          'holds the phone and follows the child\'s movement.\n',
                    ),
                  ],
                ),
                maxLines: 4,
              ),
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
} // EOF video_section_info_screen.dart
