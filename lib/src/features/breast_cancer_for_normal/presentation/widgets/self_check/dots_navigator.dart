import 'package:flutter/material.dart';

class DotsNavigator extends StatelessWidget {
  const DotsNavigator({
    super.key,
    required this.numOfDots,
    required this.currentPageIndex,
    required this.colorOfDots,
    required this.colorOfCurrentDot,
  });

  final int numOfDots;
  final int currentPageIndex;
  final Color colorOfDots;
  final Color colorOfCurrentDot;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < numOfDots; i++)
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: i == currentPageIndex ? colorOfCurrentDot : colorOfDots,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
