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

// This purpose of this widget is to look and act like a dashboard for the user, 
// It also shows the forms the users needs to take
// It would probably be the screen the user sees the most when consistenly use the app, so I tried to make it look good
class DashboardScreen extends StatefulWidget {
  final CameraDescription camera;
  const DashboardScreen({super.key, required this.camera});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // This is the main widget that holds the dashboard screen
    // It has an app bar, a body with the score and forms, and a bottom
    // navigation bar to go to different screens
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hello, User text
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorTheme.textColor, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Hello,\n${UserClass.iCResponses?[2]}!',
                    style: TextStyle(
                      fontSize: 30,
                      color: ColorTheme.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Last test result 
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorTheme.textColor, width: 3),
                    borderRadius: BorderRadius.circular(8),
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
          // List of forms
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorTheme.textColor, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Forms
                Text(
                  'Listed Forms:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Make sure to fill out these forms. '
                  'Afterwards, check out the \'video\' tab in order to start a recording section!\n',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorTheme.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // Informed Consent Document tile
                FormTile(
                  camera: widget.camera,
                  labelText: 'Informed Consent Document Form',
                  isCompleted: UserClass.formCompleted(UserClass.iCResponses),
                  description:
                      'This is the form you took at the beginning of the app. Thanks for filling it out!\n',
                  asscoiatedScreen: InformedConsentSigningScreen(
                    camera: widget.camera,
                  ),
                ),
                SizedBox(height: 16),
                // Intake tile
                FormTile(
                  camera: widget.camera,
                  labelText: 'Intake Form',
                  isCompleted:
                      UserClass.formCompleted(UserClass.childIntakeResponses) &&
                      UserClass.formCompleted(UserClass.parentIntakeResponses),
                  description:
                      'This is the form will ask just some basic questions about you and your child.\n',
                  asscoiatedScreen: ChildIntakeFormScreen(
                    camera: widget.camera,
                  ),
                ),
                SizedBox(height: 16),
                // Compensation tile
                FormTile(
                  camera: widget.camera,
                  labelText: 'Compensation Form',
                  isCompleted: UserClass.formCompleted(
                    UserClass.compensationResponses,
                  ),
                  description:
                      'This form is optional, but if you want to be compensated for your time, fill this out'
                      'Keep in mind, this form will ask for your Social Security Number.\n',
                  asscoiatedScreen: CompensationFormScreen(
                    camera: widget.camera,
                  ),
                ),
                SizedBox(height: 16),
                // mChatR tile
                FormTile(
                  camera: widget.camera,
                  labelText: 'mChatR Form',
                  isCompleted: UserClass.formCompleted(
                    UserClass.mChatRresponses,
                  ),
                  description:
                      'This class implements the mChatR form, a questionaire made up '
                      'of 20 multiple choice questions used to test for autism.\n',
                  asscoiatedScreen: MChatRFormScreen1(camera: widget.camera),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} // EOF dashboard_screen.dart
