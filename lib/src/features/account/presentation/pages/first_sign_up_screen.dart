import 'package:breast_cancer_awareness/src/features/account/presentation/pages/sign_in_screen.dart';
import 'package:flutter/gestures.dart';

import '../widgets/dont_or_already_have_accout.dart';
import '../widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class FirstSignUpScreen extends StatelessWidget {
  static const routName = '/sign-up1';

  const FirstSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -15 - keyboardHeight,
            right: 5,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/images/background_cancer_sympol.png",
                scale: 2,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/person_avatar.png",
                  scale: 2.5,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Create an account",
                style: TextStyle(
                  color: Color.fromRGBO(191, 76, 136, 1),
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 50),
              const SignUpForm(),
              const SizedBox(height: 30),
              DontOrAlreadyHaveAccount(
                text: "Already have an account ? ",
                actionText: "Sign In",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
