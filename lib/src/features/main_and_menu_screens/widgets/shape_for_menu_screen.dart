import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShapeForMenuScreen extends StatelessWidget {
  const ShapeForMenuScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shapeWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomPaint(
      size: Size(shapeWidth, shapeWidth * (isPortrait ? 2.5 : 1.5)),
      painter: PaintForMenuScreen(isDark: isDark),
    );
  }
}

class PaintForMenuScreen extends CustomPainter {
  PaintForMenuScreen({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.1130000, size.height * 0.4470000),
        Offset(size.width * 0.5000000, size.height * 0.01000000),
        [
          const Color(0xfff6a8c9).withOpacity(0.27),
          const Color(0xffff016f).withOpacity(0.27),
          const Color(0xffff006f).withOpacity(0.27),
        ],
        [0, 0.423, 1],
      );

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.quadraticBezierTo(
        size.width * 0.7768000, 0, size.width * 0.7024000, 0);
    path0.quadraticBezierTo(size.width * 0.0076000, size.height * 0.5007692,
        size.width * 0.7008000, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
