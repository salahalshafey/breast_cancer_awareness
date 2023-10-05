import 'package:flutter/material.dart';

import '../widgets/text_well_formatted.dart';

/// * [titleColor] if null it will be Colors.red.shade900
/// , this title color will be the color of (title, icon if null, ok button if action null)
///
/// * [icon] if null it will be [Icons.warning_rounded] with size 45 and the same color of [titleColor]
///
/// * [actions] if null it will be [TextButton] with text "Ok" and the same color of [titleColor]
Future<T?> showCustomAlretDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  Color? titleColor,
  Widget? icon,
  List<Widget>? actions,
  bool barrierDismissible = true,
  bool canPopScope = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (dialogContext) {
      return WillPopScope(
        onWillPop: () async {
          return canPopScope;
        },
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          titlePadding: const EdgeInsets.only(
            left: 20,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          actionsPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
          title: Row(
            children: [
              icon ??
                  Icon(
                    Icons.warning_rounded,
                    size: 45,
                    color: titleColor ?? Colors.red.shade900,
                  ),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(color: titleColor ?? Colors.red.shade900),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: TextWellFormattedWithBulleted(data: content),
          ),
          actions: [
            if (actions == null)
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
              ...actions,
          ],
          actionsAlignment: actions == null || actions.length == 1
              ? null
              : MainAxisAlignment.spaceAround,
        ),
      );
    },
  );
}

/*Future<T?> showCustomAlretDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  Color? titleColor,
  Color? contentColor,
  List<Widget>? actions,
}) =>
    showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: titleColor)),
          content: Text(
            content,
            style: TextStyle(color: contentColor, fontSize: 18),
          ),
          actions: <Widget>[
            if (actions == null)
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            else
              ...actions,
          ],
          actionsAlignment: actions == null || actions.length == 1
              ? null
              : MainAxisAlignment.spaceAround,
        );
      },
    );*/
