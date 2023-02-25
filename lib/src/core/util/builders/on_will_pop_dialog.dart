import 'package:flutter/material.dart';

Future<bool> onWillPopWithDialog(BuildContext context) async {
  return (await showDialog<bool?>(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: Future.delayed(const Duration(seconds: 15), () {
              Navigator.of(context).pop(false);
            }),
            builder: (context, snapshot) {
              return AlertDialog(
                title: const Text("Attention"),
                titleTextStyle:
                    const TextStyle(color: Colors.red, fontSize: 25),
                content: const Text("Do you really want to exit?"),
                contentTextStyle:
                    const TextStyle(color: Colors.black, fontSize: 18),
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
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
                actionsAlignment: MainAxisAlignment.spaceAround,
              );
            },
          );
        },
      )) ??
      false;
}
