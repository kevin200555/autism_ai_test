import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/screens/video_section/video_section_info_screen.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/constants/colors.dart';

//The very first screen that a user will see
class HomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const HomeScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,

      /*
      appBar: AppBar(
        title: AppBarTitle('WELCOME!', color: ColorTheme.textColor),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        actions: [HelpButton(color: ColorTheme.textColor, camera: camera)],
        automaticallyImplyLeading: false,
      ),*/
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubTitle('Background', textAlign: TextAlign.left),
              BodyText(
                'Getting an autism diagnosis for young children can still be slow and expensive. '
                'Many families miss the chance to get early support when it matters most.\n',
                color: ColorTheme.textColor,
              ),
              BodyText(
                'Our team at Washington University is working on a simple, low-cost tool '
                'that families can use at home to help spot early signs of autism.\n',
                color: ColorTheme.textColor,
              ),
              BodyText(
                'To make this possible, we need videos of real kids playing, interacting, and '
                'just being themselves.\n',
                color: ColorTheme.textColor,
              ),
              BodyText(
                'That\'s where you come in. By doing a few short tasks and recording them, '
                'you\'re helping us build something that could help many other families in the future.\n',
                color: ColorTheme.textColor,
              ),
              SubTitle('What are the video tasks?', textAlign: TextAlign.left),
              BodyText(
                '\t\t- ${InstructionAndQuestions.videoNames[0]}',
                color: ColorTheme.textColor,
              ),
              BodyText(
                '\t\t- ${InstructionAndQuestions.videoNames[1]}',
                color: ColorTheme.textColor,
              ),
              BodyText(
                '\t\t- ${InstructionAndQuestions.videoNames[2]}',
                color: ColorTheme.textColor,
              ),
              BodyText('', color: ColorTheme.textColor),
              BodyText(
                'We really appreciate your time and support!'
                ' These tasks are quick and simple, and your child might even think they’re just playing with you!\n',
                color: ColorTheme.textColor,
              ),
              BodyText(
                'This test will roughly take around 1-2 hours or so.  However, you are welcome to leave and come back '
                'at any time and have your progress saved.',
                color: ColorTheme.textColor,
              ),
              BodyText('\n\n\n\n\n\n\n\n\n', color: ColorTheme.textColor),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneralInstructionsScreen(camera: camera),
                ),
              );
            },
            //Start button
            label: ButtonText('START RECORDING', maxLines: 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorTheme.accent,
              foregroundColor: ColorTheme.alternateTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ), // rounded corners like FAB
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
//EOF home_screen.dart