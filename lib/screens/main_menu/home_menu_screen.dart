import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/main_menu/previous_videos_screen.dart';
import 'package:autism_ai_test/screens/main_menu/settings_screen.dart';
import 'package:autism_ai_test/screens/main_menu/home_screen.dart';
import 'package:autism_ai_test/screens/main_menu/dashboard_screen.dart';
import 'package:autism_ai_test/widgets/button/help_button.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// This widget is the widget that holds the screens and navigation bar that makes out the main menu
// The bottom navigation bar directs you to different screens
// Other than that, it's just a framework I guess
class HomeMenuScreen extends StatefulWidget {
  final CameraDescription camera;
  const HomeMenuScreen({super.key, required this.camera});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  int currentPageIndex = 0; 

  // Different pages
  late final List<Widget> pages = [
    DashboardScreen(camera: widget.camera,),
    HomeScreen(camera: widget.camera),
    PreviousVideosScreen(),
    SettingsScreen(camera: widget.camera),
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
} // EOF home_menu_screen.dart
