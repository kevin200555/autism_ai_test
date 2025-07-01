import 'package:autism_ai_test/themes/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//The purpose of this class is to store various configuations for AutoSizedText
//With this, I should be able to type out text, without having to worry about the text not fitting
class SubTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final double maxLines;
  final TextStyle? style;

  const SubTitle(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 12,
    this.style,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style:
            style ??
            Theme.of(context).textTheme.titleMedium?.copyWith(
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
      padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
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

class BodyTextBold extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double minFontSize;
  final TextStyle? style;

  const BodyTextBold(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.minFontSize = 8,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
      child: AutoSizeText(
        text,
        textAlign: textAlign,
        minFontSize: minFontSize,
        style:
            style ??
            Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ColorTheme.textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}