import 'dart:math';

import 'package:breast_cancer_awareness/src/features/account/presentation/providers/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const routName = '/main-screen';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Main Screens Will Be Here"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text("sign out"),
            ),
            const GetUserData(),
          ],
        ),
      ),
    );
  }
}

class GetUserData extends StatelessWidget {
  const GetUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final account = Provider.of<Account>(context, listen: false);
        final info = await account.getUserInfo();
        print(info);
      },
      child: const Text("get user data"),
    );
  }
}

/*color: Theme.of(context).colorScheme.background,
  colorBlendMode: BlendMode.hardLight,

colorFilter: ColorFilter.mode(
             Theme.of(context).colorScheme.background,
             BlendMode.hardLight,
                ),*/

extension ListExtensions<T> on List<T> {
  List<T> rotated() {
    if (isEmpty || length == 1) {
      return this;
    }

    final modefiedList = this;

    final theLast = modefiedList.last;
    modefiedList.removeLast();
    modefiedList.insert(0, theLast);
    return modefiedList;
  }

  void rotate() {
    if (isEmpty || length == 1) {
      return;
    }

    final theLast = last;
    removeLast();
    insert(0, theLast);
  }
}
