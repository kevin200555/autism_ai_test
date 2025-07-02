import 'package:autism_ai_test/screens/data_gathering/informed_consent_document_screen.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/information_screens/help_screen.dart';


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
              'While there’s much more awareness of autism today, the '
              'cost of diagnosing autism in young children is still '
              'very high, and not all pediatricians are quick to make referrals for evaluation. ',
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            BodyTextBold(
              'This means many families of '
              'children miss out on opportunities for intervention/support'
              ' during critical years of early development!',
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            BodyText(
              'Through collecting and analyzing various video-based interactions,'
              ' our research group at Washington University is working on developing a low-cost'
              ' but convenient and effective tool that is suitable for ordinary families to'
              'conduct preliminary detection of autism in young children.',
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            BodyText(
              'If you haven’t already, you will receive a gift box with items to help'
              ' you take the videos including a phone stand, a teddy bear, and bubbles. These are'
              ' yours to keep! You\'ll also need them in this test',
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            SubTitle('What\'s in the Test?', textAlign: TextAlign.left),
            BodyText('\t\t- Informed Consent Document'),
            BodyText('\t\t- Demographic Information Form'),
            BodyText('\t\t- M-ChatR Form'),
            BodyText('\t\t- Recorded Video Section'),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            BodyText('We are excited that you have agreed to help us!'),
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
                  builder: (context) => InformedConsentDocumentScreen(
                    camera: camera,
                  ),
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