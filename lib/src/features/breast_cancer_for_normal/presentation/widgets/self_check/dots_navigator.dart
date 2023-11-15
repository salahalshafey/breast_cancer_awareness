import 'package:flutter/material.dart';

class DotsNavigator extends StatelessWidget {
  const DotsNavigator({
    super.key,
    required this.numOfDots,
    required this.currentPageIndex,
    required this.colorOfDots,
    required this.colorOfCurrentDot,
    required this.gotToPageIndex,
  });

  final int numOfDots;
  final int currentPageIndex;
  final Color colorOfDots;
  final Color colorOfCurrentDot;
  final void Function(int pageIndex) gotToPageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < numOfDots; i++)
          GestureDetector(
            onTap: () => gotToPageIndex(i),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: i == currentPageIndex ? 15 : 12,
                height: i == currentPageIndex ? 15 : 12,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color:
                      i == currentPageIndex ? colorOfCurrentDot : colorOfDots,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
