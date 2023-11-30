import 'package:flutter/material.dart';

import '../widgets/text_well_formatted.dart';

/// * [titleColor] if null it will be Colors.red.shade900
/// , this title color will be the color of (title, icon if null, ok button if action null).
///
/// * [icon] if null it will be [Icons.warning_rounded] with size 45 and the same color of [titleColor].
///
/// * [actionsBuilder] if null it will be [TextButton] with text "Ok" and the same color of [titleColor].
///
/// * [contentWidget] this widget will be showen below the [content].
///
/// * [dialogDismissedAfter] if not null the dialog will be popped (Dismissed) after the given [Duration].
///
Future<T?> showCustomAlretDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  double contentFontSize = 16.0,
  Widget? contentWidget,
  Color? titleColor,
  Widget? icon,
  List<Widget> Function(BuildContext dialogContext)? actionsBuilder,
  double actionsPaddingAll = 10.0,
  BoxConstraints? constraints,
  bool barrierDismissible = true,
  bool canPopScope = true,
  Duration? dialogDismissedAfter,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) {
      if (dialogDismissedAfter != null) {
        Future.delayed(dialogDismissedAfter, () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });
      }

      return PopScope(
        canPop: canPopScope,
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          titlePadding: const EdgeInsets.only(
            left: 20,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          actionsPadding: EdgeInsets.all(actionsPaddingAll),
          title: Row(
            children: [
              icon ??
                  Icon(
                    Icons.warning_rounded,
                    size: 45,
                    color: titleColor ?? Colors.red.shade900,
                  ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: titleColor ?? Colors.red.shade900),
                ),
              ),
            ],
          ),
          content: Container(
            constraints: constraints,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextWellFormattedWithBulleted(
                    data: content,
                    fontSize: contentFontSize,
                  ),
                  if (contentWidget != null) ...[
                    const SizedBox(height: 10),
                    contentWidget,
                  ],
                ],
              ),
            ),
          ),
          actions: [
            if (actionsBuilder == null)
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: titleColor ?? Colors.red.shade900,
                  ),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              )
            else
              ...actionsBuilder(dialogContext),
          ],
          actionsAlignment: actionsBuilder == null ||
                  actionsBuilder(dialogContext).length == 1
              ? null
              : MainAxisAlignment.spaceAround,
        ),
      );
    },
  );
}
