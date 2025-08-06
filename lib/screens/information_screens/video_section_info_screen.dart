// This is section is actually a series of pages linked together
// They are connected by swipping and this is done in order to make the instructions
// easier to digest

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/data_gathering/video_recording_section_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/back_button.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/progress_bar.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';

class GeneralInstructionsScreen extends StatelessWidget {
  final CameraDescription camera;
  const GeneralInstructionsScreen({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        leading: BackButtonAppBar(),
        actions: [HelpButton(color: ColorTheme.textColor, camera: camera)],
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
                  TextSpan(
                    text: 'You\'ll be recording ',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: '3 short tasks',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  TextSpan(
                    text:
                        ' using your phone. Each task should be recorded as a',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ' separate video.',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  TextSpan(
                    text:
                        ' You can upload the videos directly through the app when you\'re done.\n',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              maxLines: 5,
            ),
            NextButton(
              label: 'NEXT',
              onPressed: () {
                UserClass.screenNumber++;
                UserClass.saveToHive();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FewTipsBeforeStart(camera: camera),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProgressBar(),
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
        leading: BackButtonAppBar(),
        actions: [HelpButton(color: ColorTheme.textColor, camera: camera)],
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
                    TextSpan(
                      text: '- Make sure your child\'s ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'face is not covered ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: '(no hats or sunglasses).\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      text: '- Try to record in a ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'quiet',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' place—turn off the TV or music.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      text: '- ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Good lighting',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' is important! Daytime is best so we can clearly see your child\'s face and body.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      text: '- ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'There\'s no right or wrong response.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' Even if your child doesn\'t respond at all,'
                          ' that\'s totally fine. Every video helps our research.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' take breaks or spread the tasks out',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' over a few days.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                          '- You\'ll find the task instructions on the next page.',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' Please read each one before recording.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
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
                UserClass.screenNumber++;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeforeYouStartScreen(camera: camera),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProgressBar(),
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
        leading: BackButtonAppBar(),
        actions: [HelpButton(color: ColorTheme.textColor, camera: camera)],
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
                    TextSpan(
                      text: '- Try to follow the steps ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'exactly as written,',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' especially when calling your child\'s name or saying a'
                          'specific sentence (e.g., “Bring me the toy”). Using the',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' exact wording',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' helps us build useful tools like audio-based detection systems.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                          '- If a sentence is included in quotation marks, please say ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'that exact sentence only once,',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' as instructed in the task.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                          '- After you finish the main prompt or question in each task,',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' keep recording for at least 30 seconds',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' or until the interaction ends naturally.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      text: '- Make sure your child\'s',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' face and body',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' are visible as much as possible throughout the video.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                UserClass.screenNumber++;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilmingTipsScreen(camera: camera),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProgressBar(),
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
        leading: BackButtonAppBar(),
        actions: [
          HelpButton(color: ColorTheme.textColor, camera: widget.camera),
        ],
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
                  TextSpan(
                    text: 'Try to keep your child\'s ',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'full body and face',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  TextSpan(
                    text:
                        ' visible in the video whenever possible. You can choose one of'
                        'the following ways to record, based on what works best for your situation:\n',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                      text: '- ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Hold the phone yourself',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' (recommended if possible): If filming alone, you can hold the phone'
                          ' casually during the task—just try to be natural and avoid making the '
                          'child feel like they are being “watched.”\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      text: '- ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Place the phone on a stable surface:',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          ' If your hands are needed for part of the task (e.g., using a'
                          ' spoon), you can briefly place the phone somewhere steady. '
                          'Just make sure the angle captures your child\'s body and face.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                      text: '- ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'Have a second person film:',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' This helps you focus on interacting with your child while someone else'
                          'holds the phone and follows the child\'s movement.\n',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                maxLines: 4,
              ),
            ),
            NextButton(
              label: 'BEGIN TEST',
              onPressed: () {
                UserClass.screenNumber++;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoRecordingSectionScreen(
                      camera: widget.camera,
                      instructions:
                          InstructionAndQuestions.getVideoInstructios(),
                      currentStep: 0,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProgressBar(),
    );
  }
} // EOF video_section_info_screen.dart
