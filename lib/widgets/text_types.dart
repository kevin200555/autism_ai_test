import 'package:autism_ai_test/constants/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppBarTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;

  const AppBarTitle(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 12,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style: style ??
            GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: ColorTheme.textColor,
              fontSize: 20,
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
    this.minFontSize = 12,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style: style ??
            GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: ColorTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
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

  const BodyText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style: style ??
            GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: ColorTheme.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
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
      child: AutoSizeText.rich(
        textSpan,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style:
            style ??
            Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ColorTheme.textColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }
}


class BoldBodyText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;

  const BoldBodyText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style: style ??
            GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: ColorTheme.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
} // EOF text_types.dart