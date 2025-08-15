import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/informed_consent/ic_document_form.dart';
import 'package:autism_ai_test/screens/intake/compensation_form.dart';
import 'package:autism_ai_test/screens/intake/intake_form_screen.dart';
import 'package:autism_ai_test/screens/mchatr/m_chatR_form_screen.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/form_tile.dart';
import 'package:autism_ai_test/widgets/home_screen_widgets.dart/score.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final CameraDescription camera;
  const DashboardScreen({super.key, required this.camera});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Greeting + Previous Test
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorTheme.textColor, width: 3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Hello,\n${UserClass.childIntakeResponses?[0]}!',
                    style: TextStyle(
                      fontSize: 30,
                      color: ColorTheme.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorTheme.textColor, width: 3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previous Test Result: \nDate: 08/04/2024\n',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PartialCircle(
                        fraction: 0.9,
                        size: 150,
                        color: ColorTheme.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // FormTile below the row
          FormTile(
            camera: widget.camera,
            labelText: 'Informed Consent Document Form',
            isCompleted: false,
            description:
                'This is the form you took at the beginning of the app. Thanks for filling it out!',
            asscoiatedScreen: InformedConsentSigningScreen(
              camera: widget.camera,
            ),
          ),
          FormTile(
            camera: widget.camera,
            labelText: 'Intake Form',
            isCompleted: false,
            description:
                'This is the form you took at the beginning of the app. Thanks for filling it out!',
            asscoiatedScreen: ChildIntakeFormScreen(
              camera: widget.camera,
            ),
          ),
          FormTile(
            camera: widget.camera,
            labelText: 'Compensation Form',
            isCompleted: false,
            description:
                'This is the form you took at the beginning of the app. Thanks for filling it out!',
            asscoiatedScreen: CompensationFormScreen(
              camera: widget.camera,
            ),
          ),
          FormTile(
            camera: widget.camera,
            labelText: 'mChatR Form',
            isCompleted: false,
            description:
                'This class implements the mChatR form, a questionaire made up '
                'of 100% multiple choice questions used to test for autism based on 20 questions',
            asscoiatedScreen: MChatRFormScreen1(
              camera: widget.camera,
            ),
          ),
        ],
      ),
    );
  }
}
