import 'package:autism_ai_test/constants/colors.dart';
import 'package:autism_ai_test/screens/information_screens/home_screen.dart';
import 'package:autism_ai_test/uploading/read_from_firebase.dart';
import 'package:autism_ai_test/uploading/user_class.dart';
import 'package:autism_ai_test/widgets/other/text_types.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// This is just a screen to thank the user for their time and to confirm their answers had been uploaded
// Later, I may what to put the results onto this screen too
class FinalScreen extends StatefulWidget {
  final CameraDescription camera;
  const FinalScreen({super.key, required this.camera});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  Future<String> loadTextFile() async {
    String content = await readTextFileFromFirebase("data/data.txt");
    return content;
  }
  String fileText = "";

  @override
  void initState() {
    super.initState();
    loadTextFile().then((value) {
      setState(() {
        fileText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: AppBarTitle(
          'Thank you for completing the test!',
          color: ColorTheme.textColor,
        ),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        automaticallyImplyLeading: false,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubTitle('All steps completed! We appreciate your time!\n'),
            // Checkmark Icon
            SizedBox(
              width: double.infinity,
              child: Icon(
                Icons.check_circle,
                color: ColorTheme.green,
                size: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            SubTitle('Results'),
            
            BodyText(fileText, color: ColorTheme.textColor,),
          ],
        ),
      ),
      //Exit button to go back to the homescreen
      floatingActionButton: SizedBox(
        width: double.infinity,
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              UserClass.resetAll();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(camera: widget.camera),
                ),
              );
            },
            label: ButtonText('EXIT', maxLines: 1),
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
} // EOF final_screen.dart
