// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/themes/colors.dart';
import 'package:autism_ai_test/themes/next_button.dart';
import 'package:autism_ai_test/themes/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class InformedConsentDocumentScreen extends StatefulWidget {
  final CameraDescription camera;
  const InformedConsentDocumentScreen({super.key, required this.camera});

  @override
  State<InformedConsentDocumentScreen> createState() =>
      _InformedConsentDocumentScreenState();
}

class _InformedConsentDocumentScreenState
    extends State<InformedConsentDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text(
          'INFORMED CONSENT DOCUMENT',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
              */
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
            BodyText(
              'Please click the link here to fill out the Informted Consent Document',
            ),
            NextButton(label: 'Next', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
