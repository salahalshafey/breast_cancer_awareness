import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color.fromRGBO(199, 40, 107, 1),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
