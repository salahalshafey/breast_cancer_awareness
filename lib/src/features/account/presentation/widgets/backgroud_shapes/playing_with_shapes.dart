import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PainteeForFirstSignUpScreen extends StatelessWidget {
  const PainteeForFirstSignUpScreen({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0, //pi / -6,
      child: Transform.scale(
        scale: 3,
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

////////////////////////////////////
///
///

class Shape3 extends StatelessWidget {
  const Shape3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: 192.5 - 710,
      left: 135 - 200,
      child: Transform.rotate(
        angle: pi / -6,
        child: Transform.scale(
          scale: 1.688,
          child: CustomPaint(
            size: Size(
              screenWidth,
              (screenWidth * 1.4075829383886256).toDouble(),
            ),
            painter: RPSCustomPainter3(),
          ),
        ),
      ),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
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
        center: Offset(size.width * 0.5000000, size.height * 0.5000000),
        width: size.width,
        height: size.height,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
