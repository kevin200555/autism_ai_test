import 'package:flutter/material.dart';

// Just a class containing color themes to keep the theme consistent
class ColorTheme {
  static Color primary = const Color.fromARGB(255, 100, 227, 255);
  static Color primaryShadow = const Color.fromARGB(200, 15, 50, 200);
  static Color accent = const Color.fromRGBO(40, 30, 150, 1);
  static Color accentShadow = const Color.fromARGB(255, 29, 119, 255);
  static Color background = const Color.fromARGB(255, 245, 247, 250);
  static Color blueBackground = const Color.fromARGB(255, 230, 245, 250);
  static Color textColor = Colors.black;
  static Color alternateTextColor = Colors.white;
  static Color red = const Color.fromARGB(255, 222, 70, 70);
  static Color green = const Color(0xFF27AE60);
  static Color greenShadow = const Color.fromARGB(117, 37, 231, 11);

  //unused colors for now
  // static Color progressBar1 = const Color.fromARGB(255, 255, 255, 85);
  // static Color progressBar2 = const Color.fromARGB(255, 170, 255, 1);
  // static Color progressBar3 = const Color.fromARGB(255, 2, 249, 2);
  static Color progressBarBackground = Colors.blueGrey;
  static Color navigationBarBackground = const Color.fromARGB(
    255,
    224,
    224,
    224,
  );
} // EOF colors.dart
