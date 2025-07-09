// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// may need to implement a feature that lets people draw their signiture
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/data_gathering/intake_form_screen.dart';
import 'package:autism_ai_test/widgets/next_button.dart';
import 'package:autism_ai_test/widgets/signiture_question_widget.dart';
import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class InformedConsentSignitureScreen extends StatefulWidget {
  final CameraDescription camera;
  const InformedConsentSignitureScreen({super.key, required this.camera});

  @override
  State<InformedConsentSignitureScreen> createState() =>
      _InformedConsentSignitureScreenState();
}

class _InformedConsentSignitureScreenState
    extends State<InformedConsentSignitureScreen> {
  var signitureQuestions = InstructionAndQuestions.getSigniture();
  List<bool?> responses = [false,false];
  // added a way to jsut screenshot the whole signiture screen in order to get user signitures
  final GlobalKey _screenShotKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Future<void> screenShot() async {
    try {
      RenderRepaintBoundary boundary =
          _screenShotKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      // Capture image with higher resolution
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get app directory to save the file
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';

      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      print('Screenshot saved to $filePath');
    } catch (e) {
      print('Error saving screenshot: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ready = responses.length >= 2;

    return RepaintBoundary(
      key: _screenShotKey,
      child: Scaffold(
        backgroundColor: ColorTheme.background,
        appBar: AppBar(
          title: AppBarTitle('SIGNITURE', color: ColorTheme.alternateTextColor),
          centerTitle: true,
          backgroundColor: ColorTheme.accent,
          iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DrawingQuestionWidget(
              question: signitureQuestions[0][1],
              value: responses[0],
              onChanged: (value) {
                setState(() {
                  responses[0] = value;
                });
              },
            ),
            DrawingQuestionWidget(
              question: signitureQuestions[1][1],
              value: responses[1],
              onChanged: (value) {
                setState(() {
                  responses[1] = value;
                });
              },
            ),
            NextButton(
              label: 'SUBMIT SIGNITURES',
              onPressed: () {
                screenShot();
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
} // EOF ic_document_signing.dart
