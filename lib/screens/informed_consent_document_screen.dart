// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/screens/intake_form_screen.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
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
            BodyText(
              'Please click the link here to fill out the Informted Consent Document',
            ),
            NextButton(
              label: 'Next',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        IntakeFormScreen(camera: widget.camera),
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
