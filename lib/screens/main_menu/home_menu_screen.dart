import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomeMenuScreen extends StatefulWidget {
  final CameraDescription camera;
  const HomeMenuScreen({super.key, required this.camera});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 0;
    NavigationDestinationLabelBehavior labelBehavior =
        NavigationDestinationLabelBehavior.alwaysShow;

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle('Autism Tracker', color: ColorTheme.background),
        centerTitle: true,
        backgroundColor: ColorTheme.accent,
        actions: [
          HelpButton(color: ColorTheme.background, camera: widget.camera),
        ],
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Previous Videos',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
