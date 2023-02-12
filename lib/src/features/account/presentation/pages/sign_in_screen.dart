import 'first_sign_up_screen.dart';
import '../widgets/sign_in_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatelessWidget {
  static const routName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -205,
            right: -65,
            child: Opacity(
              opacity: 0.58,
              child: SvgPicture.asset(
                "assets/images/background_flower.svg",
                height: 350,
              ),
            ),
          ),
          Positioned(
            bottom: -14 - _keyboardHeight,
            left: -165,
            child: Opacity(
              opacity: 0.58,
              child: SvgPicture.asset(
                "assets/images/background_flower.svg",
                height: 350,
              ),
            ),
          ),
          Positioned(
            bottom: -15 - _keyboardHeight,
            right: 5,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/images/background_cancer_sympol.png",
                scale: 3,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            children: [
              const Text(
                "Log in",
                style: TextStyle(
                  color: Color.fromRGBO(191, 76, 136, 1),
                  fontSize: 26,
                ),
              ),
              const Text(
                "Please sign in to continue",
                style: TextStyle(
                  color: Color.fromRGBO(206, 50, 116, 0.76),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/person_avatar.png",
                  scale: 1.5,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(height: 50),
              const SignInForm(),
              const SizedBox(height: 70),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    color: Color.fromRGBO(143, 39, 83, 1),
                    fontSize: 18,
                  ),
                  children: [
                    const TextSpan(text: "Don't have an account ? "),
                    TextSpan(
                      text: "Sign Up",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushReplacementNamed(FirstSignUpScreen.routName);
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
