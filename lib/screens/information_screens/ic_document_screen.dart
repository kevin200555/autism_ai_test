import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/data_gathering/ic_document_form.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/button/back_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

// This module lets the user view the Informed Consent document (in the assets folder)
// its a widget that could integreate a pdf
// I was going to let the user just sign on this screen, but the document was way too small to both read and try to sign
// and there not really a good way to scroll without accidentally drawing or draw without accidentally scrolling 
class PdfViewerScreen extends StatefulWidget {
  final CameraDescription camera;
  const PdfViewerScreen({super.key, required this.camera});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late final PdfControllerPinch _pdfController;

  // inititate the pdf controller, this is what lets us interact with the document
  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      //change this if it gets updated or I change the name
      document: PdfDocument.openAsset('assets/documents/icDocument.pdf'),
    );
  }

  // removes the controller
  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonAppBar(),
        // title
        title: AppBarTitle(
          'Informed Consent Document',
          color: ColorTheme.textColor,
        ),
      ),
      //Views the PDF
      body: PdfViewPinch(controller: _pdfController),
      //Next button
      floatingActionButton: SizedBox(
        width: double.infinity,
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              UserClass.screenNumber++;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InformedConsentSigningScreen(camera: widget.camera),
                ),
              );
            },
            label: ButtonText('SIGN ON NEXT PAGE', maxLines: 1),
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
} // ic_document_screen.dart
