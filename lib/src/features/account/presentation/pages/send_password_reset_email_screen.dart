import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/password_reset_form.dart';

class SendPasswordResetEmailScreen extends StatelessWidget {
  static const routName = '/password-reset';

  const SendPasswordResetEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40.0;
    }

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
          Positioned(
            bottom: -15 - keyboardHeight,
            right: 5,
            child: Opacity(
              opacity: 0.48,
              child: Image.asset(
                "assets/images/background_cancer_sympol.png",
                height: 90,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: horizantalPadding, vertical: 60),
            children: const [
              SizedBox(height: 50),
              Text(
                "Forgot your password?",
                style: TextStyle(
                  color: Color.fromRGBO(191, 76, 136, 1),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Put your Email to send a link for resetting your password.",
                style: TextStyle(
                  color: Color.fromRGBO(206, 50, 116, 0.76),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 50),
              PasswordResetForm(),
            ],
          ),
        ],
      ),
    );
  }
}
