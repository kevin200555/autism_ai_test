import 'package:autism_ai_test/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// The purpose of this file is to store various configuations for AutoSizedText
// With this, I should be able to type out text, without having to worry about the text not fitting
// These are used heavily throughout the app, so I thought it would be best to put them in a separate file
// There are various text types, such as AppBarTitle, SubTitle, QuestionText, BodyText, etc.
// I feel each is self-explanatory for what each one is used for

// AppBarTitle is used for the title of the app bar
class AppBarTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLines;
  final double minFontSize;
  final TextStyle? style;
  final Color color;

  const AppBarTitle(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 12,
    this.style,
    this.maxLines = 1,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      minFontSize: minFontSize,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

// Subtitle is used for subtitles or secondary titles
// It is smaller than the AppBarTitle and is used for important text in the body of the app
class SubTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;

  final TextStyle? style;

  const SubTitle(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 10,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: SizedBox(
        width: double.infinity,
        child: AutoSizeText(
          text,
          textAlign: textAlign,
          minFontSize: minFontSize,
          maxLines: 1,
          style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// QuestionText is used for questions in the app
// similar to Subtitle, with slightly different styling
class QuestionText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;

  final TextStyle? style;

  const QuestionText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 10,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: SizedBox(
        width: double.infinity,
        child: AutoSizeText(
          text,
          textAlign: textAlign,
          minFontSize: minFontSize,
          maxLines: 3,
          style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// The most commonly used text type, takes in color as well as text in order to write
class BodyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;

  const BodyText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
    required Color color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: SizedBox(
        width: double.infinity,
        child: AutoSizeText.rich(
          TextSpan(
            text: text,
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          textAlign: textAlign,
          minFontSize: minFontSize,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: ColorTheme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

//Similar to BodyText, except it also comes with the ability to italicize 
class QuestionBodyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;
  final int maxLines;
  final bool isItalics;

  const QuestionBodyText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
    required this.maxLines, required this.isItalics,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
      child: SizedBox(
        width: double.infinity,
        child: AutoSizeText.rich(
          TextSpan(
            text: text,
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          textAlign: textAlign,
          minFontSize: minFontSize,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: ColorTheme.textColor,
              fontStyle: (isItalics) ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}
// The text displayed on buttons
class ButtonText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;
  final int maxLines;

  const ButtonText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      minFontSize: minFontSize,
      maxLines: maxLines,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontSize: 16,
          color: ColorTheme.alternateTextColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// used for text where some of the text is bolded
// It is used for instructions or important text in the app
class RichBodyText extends StatelessWidget {
  final TextSpan textSpan;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;

  const RichBodyText(
    this.textSpan, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: SizedBox(
        width: double.infinity,
        child: AutoSizeText.rich(
          textSpan,
          textAlign: textAlign,
          minFontSize: minFontSize,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorTheme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

// EOF text_types.dart
