import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CodeContainer extends StatelessWidget {
  const CodeContainer({
    super.key,
    required this.code,
    required this.languageName,
    this.animateTheCode = false,
  });

  final String code;
  final String languageName;
  final bool animateTheCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade800,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languageName,
                  style: const TextStyle(color: Colors.white),
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.copy, color: Colors.white),
                    SizedBox(width: 7),
                    Text(
                      "Copy code",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: animateTheCode
                ? Animate().custom(
                    duration: (code.length * 10).ms,
                    begin: 0,
                    end: code.length.toDouble(),
                    builder: (_, value, __) {
                      return SelectableText(
                        code.substring(0, value.toInt()),
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  )
                : SelectableText(
                    code,
                    style: const TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }
}
