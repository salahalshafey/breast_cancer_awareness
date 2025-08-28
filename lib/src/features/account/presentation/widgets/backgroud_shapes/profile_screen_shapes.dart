import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShapeForProfileScreen extends StatelessWidget {
  const ShapeForProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final shapeWidth =
        MediaQuery.of(context).size.width * (isPortrait ? 0.7 : 0.5);

    return Transform.flip(
      flipX: Directionality.of(context) == TextDirection.rtl,
      child: CustomPaint(
        size: Size(shapeWidth, shapeWidth * (isPortrait ? 2 : 1.5)),
        painter: PaintForProfileScreen(),
      ),
    );
  }
}

class PaintForProfileScreen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.1130000, size.height * 0.4470000),
        Offset(size.width * 0.5000000, size.height * 0.01000000),
        [
          const Color(0xfff6a8c9).withValues(alpha: 0.27),
          const Color(0xffff016f).withValues(alpha: 0.27),
          const Color(0xffff006f).withValues(alpha: 0.27),
        ],
        [0, 0.423, 1],
      );

    Path path0 = Path();
    path0.moveTo(size.width, size.height * -0.0020000);
    path0.lineTo(size.width, size.height * -0.0020000);
    path0.quadraticBezierTo(size.width * 0.5090000, size.height * 0.5020000,
        size.width, size.height * 0.9980000);
    path0.quadraticBezierTo(size.width * 1.0830000, size.height * 0.9980000,
        size.width, size.height * 0.9980000);
    path0.lineTo(size.width, size.height * -0.0020000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
