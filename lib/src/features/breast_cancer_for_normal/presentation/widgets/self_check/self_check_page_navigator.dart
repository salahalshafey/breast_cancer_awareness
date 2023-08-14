import 'package:flutter/material.dart';

class SelfCheckPageNavigator extends StatelessWidget {
  const SelfCheckPageNavigator({
    super.key,
    required this.numOfPages,
    required this.currentPageIndex,
    required this.gotToNextPage,
    required this.gotToPrevPage,
    required this.color,
  });

  final int numOfPages;
  final int currentPageIndex;
  final void Function() gotToNextPage;
  final void Function() gotToPrevPage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: currentPageIndex == 0 ? null : gotToPrevPage,
          icon: Icon(
            Icons.navigate_before,
            color: currentPageIndex == 0 ? Colors.grey : color,
            size: 40,
          ),
          tooltip: currentPageIndex == 0
              ? "This Is The First Step"
              : "Previous Step",
        ),
        Text(
          "Self-check\n" "${currentPageIndex + 1} of $numOfPages",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        IconButton(
          onPressed: gotToNextPage,
          icon: Icon(
            currentPageIndex == numOfPages - 1
                ? Icons.close
                : Icons.navigate_next,
            color: color,
            size: 40,
          ),
          tooltip: currentPageIndex == numOfPages - 1
              ? "End Self-check"
              : "Next Step",
        ),
      ],
    );
  }
}
