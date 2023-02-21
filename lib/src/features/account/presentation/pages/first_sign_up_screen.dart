import 'package:flutter/material.dart';

import '../widgets/backgroud_shapes/first_sign_up_screen_shapes.dart';
import '../widgets/dont_or_already_have_accout.dart';
import '../widgets/sign_up_form.dart';

class FirstSignUpScreen extends StatelessWidget {
  static const routName = '/sign-up1';

  const FirstSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final screenWidth = MediaQuery.of(context).size.width;

    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40;
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 0,
            child: ShapeForFirsrSignUpScreen(),
          ),
          // if (Theme.of(context).brightness == Brightness.light)
          Positioned(
            bottom: -15 - keyboardHeight,
            right: 5,
            child: Opacity(
              opacity: 0.48,
              child: Image.asset(
                "assets/images/background_cancer_sympol.png",
                height: 120,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: horizantalPadding, vertical: 60),
            children: [
              const SizedBox(height: 30),
              Opacity(
                opacity: 0.8,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/person_avatar.png",
                    scale: 2.5,
                    filterQuality: FilterQuality.high,
                  ),
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
