import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import 'second_sign_up_screen.dart';

import '../../../settings/widgets/set_theme_mode.dart';
import '../widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  static const routName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40.0;
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
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
            bottom: -14 - keyboardHeight,
            left: -165,
            child: Opacity(
              opacity: 0.58,
              child: SvgPicture.asset(
                "assets/images/background_flower.svg",
                height: 350,
              ),
            ),
          ),
          if (Theme.of(context).brightness == Brightness.light)
            Positioned(
              bottom: -15 - keyboardHeight,
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
            padding: EdgeInsets.symmetric(
                horizontal: horizantalPadding, vertical: 60),
            children: [
              const SizedBox(height: 35),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SecondSignUpScreen.routName);
                },
                child: const Text("go"),
              ),
              const SizedBox(height: 30),
              const SetThemeMode(),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/person_avatar.png",
                  scale: 1.5,
                  filterQuality: FilterQuality.high,
                ),
              ).animate(delay: 1.5.seconds).shimmer(duration: 1.seconds),
              const SizedBox(height: 30),
              const SignInForm(),
            ],
          ),
        ],
      ),
    );
  }
}
