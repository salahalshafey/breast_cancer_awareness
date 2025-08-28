import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShapeForFirsrSignUpScreen extends StatelessWidget {
  const ShapeForFirsrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return CustomPaint(
      size: Size(
        screenWidth,
        (screenWidth * (isPortrait ? 0.5833333333333334 : 0.3)).toDouble(),
      ),
      painter: PaintForFirstSignUpScreen(),
    );
  }
}

class PaintForFirstSignUpScreen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.07300000, size.height * 0.9090000),
        Offset(size.width * 0.3180000, size.height * 0.9460000),
        [
          const Color(0xffe6106b).withValues(alpha: 0.27),
          const Color(0xff7b5465).withValues(alpha: 0.27),
        ],
        [0, 1],
      );

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.5630769, size.width,
        size.height * 0.7507692);
    path0.quadraticBezierTo(size.width * 0.5292000, size.height * 1.1576923, 0,
        size.height * 0.5815385);
    path0.lineTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
