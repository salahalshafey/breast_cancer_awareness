import 'package:flutter/material.dart';

class TextNormal extends StatelessWidget {
  const TextNormal({
    super.key,
    required this.data,
    required this.fontSize,
    this.color,
  });

  final String data;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.data,
    required this.fontSize,
    this.color,
  });

  final String data;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
