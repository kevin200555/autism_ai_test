import 'package:autism_ai_test/screens/information_screens/ic_document_screen.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/help_screens/help_screen.dart';

//The very first screen that a user will see
class HomeScreen extends StatelessWidget {
  final CameraDescription camera;
  const HomeScreen({super.key, required this.camera});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text('WELCOME!', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            },
            icon: const Icon(Icons.question_mark_outlined),
          ),
        ],
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('Background', textAlign: TextAlign.left),
            BodyText(
              'Getting an autism diagnosis for young children can still be slow and expensive.'
              'Many families miss the chance to get early support when it matters most.\n',
            ),
            BodyText(
              'Our team at Washington University is working on a simple, low-cost tool '
              'that families can use at home to help spot early signs of autism.\n',
            ),
            BodyText(
              'To make this possible, we need videos of real kids—playing, interacting, and'
              'just being themselves.\n',
            ),
            BodyText(
              'That\'s where you come in. By doing a few short tasks and recording them'
              ', you\'re helping us build something that could help many other families in the future.\n',
            ),
            SubTitle('What\'s in the Test?', textAlign: TextAlign.left),
            BodyText('\t\t- Informed Consent Document'),
            BodyText('\t\t- Autism Intake Form'),
            BodyText('\t\t- M-ChatR Form'),
            BodyText('\t\t- Recorded Video Section\n\n'),
            BodyText(
              'We really appreciate your time and support!'
              ' These tasks are quick and simple, and your child might even think they’re just playing with you!',
            ),
          ],
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
                  builder: (context) =>
                      PdfViewerScreen(camera: camera),
                ),
              );
            },
            label: AutoSizeText(
              'BEGIN TEST',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: ColorTheme.alternateTextColor,
              ),
              maxLines: 1,
              minFontSize: 12,
            ),
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