import 'package:flutter/material.dart';

class TextNormal extends StatelessWidget {
  const TextNormal({
    super.key,
    required this.data,
    required this.fontSize,
  });

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(
        //color: const Color.fromRGBO(199, 40, 107, 1),
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
  });

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(
        //color: const Color.fromRGBO(199, 40, 107, 1),
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
