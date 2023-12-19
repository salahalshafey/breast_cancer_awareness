import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              ? AppLocalizations.of(context)!.thisIsTheFirstStep
              : AppLocalizations.of(context)!.previousStep,
        ),
        Text(
          "${AppLocalizations.of(context)!.selfcheck}\n"
          "${AppLocalizations.of(context)!.pageOf(currentPageIndex + 1, numOfPages)}",
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
              ? AppLocalizations.of(context)!.endSelfcheck
              : AppLocalizations.of(context)!.nextStep,
        ),
      ],
    );
  }
}
