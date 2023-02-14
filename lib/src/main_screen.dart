import 'dart:math';

import 'package:breast_cancer_awareness/src/features/account/presentation/providers/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.translationValues(50, 100, 0)
                //..scale(2, 2, 2)
                ..rotateZ(pi / -3),
              child: CustomPaint(
                size: Size(422, (422 * 1.0950332320446576).toDouble()),
                painter: RPSCustomPainter(),
              ),
            ),
            const Text("Main Screens Will Be Here"),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text("sign out"),
            ),
            const GetUserData(),
          ],
        ),
      ),
    );
  }
}

class GetUserData extends StatelessWidget {
  const GetUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final account = Provider.of<Account>(context, listen: false);
        final info = await account.getUserInfo();
        print(
            "${info.firstName}, ${info.lastName}, ${info.id}, ${info.imageURl}, ${info.userType}");
      },
      child: Text("get user data"),
    );
  }
}

class PaintForFirstSignUpScreen extends StatelessWidget {
  const PaintForFirstSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(422, (422 * 1.0950332320446576).toDouble()),
      painter: RPSCustomPainter(),
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
        Color(0xffe6106b).withOpacity(0.27),
        Color(0xff7b5465).withOpacity(0.27),
      ],
      [0, 1],
    );
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.3185084, size.height * 0.4094186),
            width: size.width * 0.6370167,
            height: size.height * 0.8188371),
        paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
