import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

import '../widgets/backgroud_shapes/sign_in_screen_shapes.dart';
import '../widgets/password_reset_form.dart';

class SendPasswordResetEmailScreen extends StatelessWidget {
  static const routName = '/password-reset';

  const SendPasswordResetEmailScreen({super.key});

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
            padding: EdgeInsets.symmetric(
                horizontal: horizantalPadding, vertical: 60),
            children: [
              const SizedBox(height: 50),
              Text(
                AppLocalizations.of(context)!.forgotYourPassword,
                style: const TextStyle(
                  color: Color.fromRGBO(191, 76, 136, 1),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!
                    .putYourEmailToSendALinkForResettingYourPassword,
                style: const TextStyle(
                  color: Color.fromRGBO(206, 50, 116, 0.76),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),
              const PasswordResetForm(),
            ],
          ),
        ],
      ),
    );
  }
}
