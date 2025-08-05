import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:flutter/material.dart';

class NoCameraErrorScreen extends StatelessWidget {
  const NoCameraErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: BodyText('So you\'re REALLY not meant to see this screen so '
        'if you\'re seeing this, it probably means that something is wrong with your camera '
        'or if you don\'t have a camera, either way contact Kevin Li (kevinli200555@gmail.com) '
        'and let me know what device you are using and we\'ll figure out what went wrong'
        'Sorry for the inconvience',
        maxLines: 10,),
      ),
    );
  }
}
