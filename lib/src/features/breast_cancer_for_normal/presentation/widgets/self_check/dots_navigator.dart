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
            child: Row(
              children: [
                const Text(" "),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color:
                        i == currentPageIndex ? colorOfCurrentDot : colorOfDots,
                    shape: BoxShape.circle,
                  ),
                ),
                const Text(" "),
              ],
            ),
          ),
      ],
    );
  }
}
