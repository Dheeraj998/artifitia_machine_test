import 'package:flutter/material.dart';

class FnText extends StatelessWidget {
  const FnText(
      {super.key,
      this.color,
      this.height,
      this.overflow,
      this.textAlign,
      this.fontWeight,
      this.decoration,
      this.maxLines,
      required this.text,
      this.letterSpacing,
      this.fontSize = 15,
      this.fontStyle});

  final String text;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontStyle: fontStyle,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        overflow: overflow,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
