import 'package:flutter/material.dart';
import 'custom_alret_dialoge.dart';

Future<bool> onWillPopWithDialog(BuildContext context) async {
  return (await showCustomAlretDialog<bool>(
        context: context,
        title: "Attention",
        titleColor: Colors.red,
        content: "Do you really want to exit?",
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
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
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
