import 'package:flutter/material.dart';

class FirstSignUpScreen extends StatelessWidget {
  static const routName = '/sign-up1';

  const FirstSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("first sign up screen."),
      ),
    );
  }
}
