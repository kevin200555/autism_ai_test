// just some demographic questions
// may need to make a "Choose all that apply type question"
// Screen that basically shows terms and conditions
// has some MCQ and SAQ questions

import 'package:autism_ai_test/constants/instruction_and_questions.dart';
import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/intake/intake_form_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/back_button.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/button/next_button.dart';
import 'package:autism_ai_test/widgets/other/progress_bar.dart';
import 'package:autism_ai_test/widgets/questions/signiture_question_widget.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// this was all the stuff I needed for the screenshot
import 'dart:ui' as ui;
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
  // responses keeps track of whether or not the user actually wrote something in the signiture boxes
  // It will not go to the next page until the user has wrote something
  List<bool?> responses = [false, false];
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
          '${directory.path}/signiture_screenshot_${DateTime.now().millisecondsSinceEpoch}.png';

      final file = File(filePath);
      UserClass.signiture = file;
      await file.writeAsBytes(pngBytes);
    } catch (e) {
      FlutterError.reportError(FlutterErrorDetails(exception: e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _screenShotKey,
      child: Scaffold(
        backgroundColor: ColorTheme.background,
        appBar: AppBar(
          leading: BackButtonAppBar(),
          actions: [
            HelpButton(
              color: ColorTheme.alternateTextColor,
              camera: widget.camera,
            ),
          ],
          title: AppBarTitle('SIGNITURE', color: ColorTheme.alternateTextColor),
          centerTitle: true,
          backgroundColor: ColorTheme.accent,
          iconTheme: IconThemeData(color: ColorTheme.alternateTextColor),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Signiture of Parent/Guardian
            DrawingQuestionWidget(
              question: signitureQuestions[0][1],
              value: responses[0],
              onChanged: (value) {
                setState(() {
                  responses[0] = value;
                });
              },
            ),
            // Signiture of Person who obtained Consent
            DrawingQuestionWidget(
              question: signitureQuestions[1][1],
              value: responses[1],
              onChanged: (value) {
                setState(() {
                  responses[1] = value;
                });
              },
            ),
            // Next Button
            NextButton(
              label: 'SUBMIT SIGNITURES',
              onPressed: () async {
                if (responses[0] == false || responses[1] == false) {
                  await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Please sign signitures first'),
                    ),
                  );
                  return;
                } else {
                  await WidgetsBinding.instance.endOfFrame;

                  await screenShot();
                  // SAVE TO HIVE
                  UserClass.screenNumber++;
                  UserClass.saveToHive();
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChildIntakeFormScreen(camera: widget.camera),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: ProgressBar(),
      ),
    );
  }
} // EOF ic_document_signing.dart
