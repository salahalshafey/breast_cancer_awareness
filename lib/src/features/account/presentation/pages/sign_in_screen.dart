import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';

class SignInScreen extends StatelessWidget {
  static const routName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: "salahalshafey@gmail.com",
                password: "123456789",
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                showCustomAlretDialog(
                  context: context,
                  title: "Error",
                  titleColor: Colors.red,
                  content: "There is no user with this email.",
                );
              } else if (e.code == 'wrong-password') {
                showCustomAlretDialog(
                  context: context,
                  title: "Error",
                  titleColor: Colors.red,
                  content: "Wrong password provided for that user.",
                );
              } else {
                showCustomAlretDialog(
                  context: context,
                  title: "Error",
                  titleColor: Colors.red,
                  content: e.code,
                );
              }
            }
          },
          child: const Text("sign in"),
        ),
      ),
    );
  }
}
