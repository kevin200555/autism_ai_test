import 'package:flutter/material.dart';


class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help and Information',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 1, 51, 93),
      ),
      body: Column(
         children: [
          SizedBox(
            height: 100
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              textAlign: TextAlign.center,
              'Welcome! The purpose of this app is to integrate an AI model that is meant to '
              'determine whether or not the patient has autism or not.  To do that, we need you to'
              'fill out some questionaires nad take a few videos of your child'
              'Because of this, we will need access to your camera and audio'
              'After that, your results will be uploaded to the AI model that will determine the likeihood'
              'that your child has autism.  To begin, go back to the home screen and click the start button.'
              'Thank you for helping us, we appreicate your support!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          
         ]
      )
     
    );
  }
}