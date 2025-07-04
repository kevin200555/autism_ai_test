import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/data_gathering/ic_document_signing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerScreen extends StatefulWidget {
  final CameraDescription camera;
  const PdfViewerScreen({super.key, required this.camera});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late final PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/test.pdf'),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informed Consent Document'),
      ),
      body: PdfViewPinch(
        controller: _pdfController,
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
                      InformedConsentSigningScreen(camera: widget.camera),
                ),
              );
            },
            label: AutoSizeText(
              'SIGN ON NEXT PAGE',
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
