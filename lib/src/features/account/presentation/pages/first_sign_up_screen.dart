import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/backgroud_shapes/first_sign_up_screen_shapes.dart';
import '../widgets/sign_up_form.dart';

class FirstSignUpScreen extends StatelessWidget {
  static const routName = '/sign-up1';

  const FirstSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final screenWidth = MediaQuery.of(context).size.width;

    var horizantalPadding = 25.0;
    if (screenWidth > 600) {
      horizantalPadding += (screenWidth - 600) / 2;
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Transform.flip(
              flipX: Directionality.of(context) == TextDirection.rtl,
              child: const ShapeForFirsrSignUpScreen(),
            ),
          ),
          Positioned(
            bottom: -15 - keyboardHeight,
            right: Directionality.of(context) == TextDirection.ltr ? 5 : null,
            left: Directionality.of(context) == TextDirection.rtl ? 5 : null,
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
                  child: Transform.flip(
                    flipX: Directionality.of(context) == TextDirection.rtl,
                    child: Image.asset(
                      "assets/images/person_avatar.png",
                      scale: 2.5,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.createAnAccount,
                style: const TextStyle(
                  color: Color.fromRGBO(191, 76, 136, 1),
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 50),
              const SignUpForm(),
            ],
          ),
        ],
      ),
    );
  }
}
