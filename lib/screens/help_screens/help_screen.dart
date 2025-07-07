import 'package:autism_ai_test/widgets/text_types.dart';
import 'package:flutter/material.dart';
import 'package:autism_ai_test/constants/colors.dart';

//Just diaplays some information of the purpose of this app and how to use it to the user
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      appBar: AppBar(
        title: Text('HELP MENU', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: ColorTheme.background,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            },
            icon: const Icon(Icons.question_mark_outlined),
          ),
        ],
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarTitle('Questions?', textAlign: TextAlign.left),
            BodyText(
              'If you have any questions regarding how to record and upload your videos, please feel free to e-mail Daniel '
              'Gray (drgray@wustl.edu) and Jerry Yu (xiangxu@wustl.edu). Jerry is also available via text/phone at 737-'
              '529-5080. After you upload videos, we will review the videos and let you know if there are any problems.',
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            BodyText(
              'For any questions reguarding the app itself, Contact Kevin Li (kevinli200555@gmail.com)'
              'if their are any problems.'
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            BodyText('Any suggestions, recommendations or comments you have are also welcome!')
          ],
        ),
      ),
    );
  }
} // EOF help_screen.dart