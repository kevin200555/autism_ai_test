import 'package:autism_ai_test/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      style:
          style ??
          GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}

//The purpose of this class is to store various configuations for AutoSizedText
//With this, I should be able to type out text, without having to worry about the text not fitting
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
        height: MediaQuery.sizeOf(context).height * 0.035,
        child: AutoSizeText(
          text,
          textAlign: textAlign,
          minFontSize: minFontSize,
          maxLines: 1,
          style:
              style ??
              GoogleFonts.lato(
                color: ColorTheme.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

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
          style:
              style ??
              GoogleFonts.lato(

                  color: ColorTheme.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

              ),
        ),
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;
  final int maxLines;

  const BodyText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.025 * maxLines,
        child: AutoSizeText(
          text,
          textAlign: textAlign,
          minFontSize: minFontSize,
          maxLines: maxLines,
          style:
              style ??
              GoogleFonts.lato(
                color: ColorTheme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}

class RichBodyText extends StatelessWidget {
  final TextSpan textSpan;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;
  final int maxLines;

  const RichBodyText(
    this.textSpan, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.025 * maxLines,
        child: AutoSizeText.rich(
          textSpan,
          textAlign: textAlign,
          minFontSize: minFontSize,
          maxLines: maxLines,
          style:
              style ??
              GoogleFonts.lato(
                  color: ColorTheme.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
