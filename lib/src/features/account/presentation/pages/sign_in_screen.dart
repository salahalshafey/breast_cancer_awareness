import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../settings/widgets/change_language_for_sign_in.dart';
import '../../../settings/widgets/toggle_theme_button.dart';
import '../widgets/backgroud_shapes/sign_in_screen_shapes.dart';
import '../widgets/sign_in/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  static const routName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40.0;
    }

    return Scaffold(
      body: Stack(
        children: [
          ...singInBackGroundShapes(context),
          ListView(
            padding: EdgeInsets.only(
              left: horizantalPadding,
              right: horizantalPadding,
              top: 60,
              bottom: 10,
            ),
            children: [
              /*   const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.logIn,
                    style: const TextStyle(
                      color: Color.fromRGBO(191, 76, 136, 1),
                      fontSize: 26,
                    ),
                  ),
                  const ChangLanguageForSignIn(),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.pleaseSignInToContinue,
                style: const TextStyle(
                  color: Color.fromRGBO(206, 50, 116, 0.76),
                  fontSize: 20,
                ),
              ), */
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: ChangLanguageForSignIn(),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: ToggleThemeButton(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Transform.flip(
                  flipX: Directionality.of(context) == TextDirection.rtl,
                  child: Image.asset(
                    "assets/images/person_avatar.png",
                    scale: 1.5,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ).animate(delay: 1.seconds).shimmer(duration: 1.seconds),
              const SizedBox(height: 30),
              const SignInForm(),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
