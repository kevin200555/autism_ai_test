import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/main_menu/dashboard_screen.dart';
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
  int currentPageIndex = 0; 

  // Your different pages
  late final List<Widget> pages = [
    DashboardScreen(),
    Center(child: Text("Recording Screen")),
    Center(child: Text("Previous Videos Screen")),
    Center(child: Text("Settings Screen")),
  ];

  @override
  Widget build(BuildContext context) {
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
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        backgroundColor: ColorTheme.navigationBarBackground,
        indicatorColor: ColorTheme.primary,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: '',),
          NavigationDestination(icon: Icon(Icons.camera_alt), label: '',),
          NavigationDestination(
            icon: Icon(Icons.video_library),
            label: '',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
