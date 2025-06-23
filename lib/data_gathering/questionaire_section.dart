import 'package:autism_ai_test/data_gathering/video_recording_section.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuidedQuestionaire extends StatefulWidget {
  final List<String> urls;
  final CameraDescription camera;
  final List<String> instructions;
  const GuidedQuestionaire({super.key, required this.urls, required this.camera, required this.instructions});

  @override
  State<GuidedQuestionaire> createState() => _GuidedQuestionaireState();
}

class _GuidedQuestionaireState extends State<GuidedQuestionaire> {
  int currentSurvey = 0;
  void nextSurvey() {
    if (currentSurvey < widget.urls.length - 1) {
      setState(() {
        currentSurvey++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GuidedVideoRecording(camera: widget.camera, instructions: widget.instructions,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..loadRequest(Uri.parse(widget.urls[currentSurvey]))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Step ${currentSurvey + 1} of ${widget.urls.length}',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
      ),
      body: WebViewWidget(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: nextSurvey,
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
        foregroundColor: Colors.white,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
