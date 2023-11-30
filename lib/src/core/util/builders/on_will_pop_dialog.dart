import 'package:flutter/material.dart';
import 'custom_alret_dialoge.dart';

Future<bool> exitWillPopDialog(BuildContext context) async {
  return (await showCustomAlretDialog<bool>(
        context: context,
        canPopScope: false,
        barrierDismissible: false,
        dialogDismissedAfter: const Duration(seconds: 5),
        title: "Attention",
        titleColor: Colors.red,
        content: "Do you really want to exit?",
        actionsBuilder: (dialogContext) => [
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            child: const Text("  Exit  "),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false);
            },
            style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.red),
              side: MaterialStatePropertyAll(BorderSide(color: Colors.red)),
            ),
            child: const Text("Cancel"),
          ),
        ],
      )) ??
      false;
}

/*Future<bool> onWillPopWithDialog(BuildContext context) async {
  return (await showDialog<bool?>(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: Future.delayed(const Duration(seconds: 15), () {
              Navigator.of(context).pop(false);
            }),
            builder: (context, snapshot) {
              return AlertDialog(
                title: const Text(
                  "Attention",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                content: const Text(
                  "Do you really want to exit?",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        color:
                            Theme.of(context).appBarTheme.titleTextStyle!.color,
                      ),
                    ),
                  ),
                ],
                actionsAlignment: MainAxisAlignment.spaceAround,
              );
            },
          );
        },
      )) ??
      false;
}*/
