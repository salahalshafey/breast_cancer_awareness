import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter_svg/svg.dart';

import '../widgets/dont_or_already_have_accout.dart';
import '../widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class FirstSignUpScreen extends StatelessWidget {
  static const routName = '/sign-up1';

  const FirstSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40;
    }
    print(screenWidth);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -430, // -415 - 500, //-490
            left: 150,
            child: PaintForFirstSignUpScreen(
                width:
                    400), /*Transform.rotate(
              angle: 0,
              child: Transform.scale(
                scale: 2.5,
                child: SvgPicture.asset(
                  "assets/images/shape_sign_up1.svg",
                  width: screenWidth,
                ),
              ),
            ),*/
          ),
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

class PaintForFirstSignUpScreen extends StatelessWidget {
  const PaintForFirstSignUpScreen({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / -6,
      child: Transform.scale(
        scale: 2.5,
        child: CustomPaint(
          size: Size(width, (width * 1.0950332320446576).toDouble()),
          painter: RPSCustomPainter(),
        ),
      ),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;

    paint0Fill.shader = ui.Gradient.linear(
      Offset(size.width * 0.07300000, size.height * 0.9090000),
      Offset(size.width * 0.3180000, size.height * 0.9460000),
      [
        const Color(0xffe6106b).withOpacity(0.27),
        const Color(0xff7b5465).withOpacity(0.27),
      ],
      [0, 1],
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.3185084, size.height * 0.4094186),
        width: size.width * 0.6370167,
        height: size.height * 0.8188371,
      ),
      paint0Fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
