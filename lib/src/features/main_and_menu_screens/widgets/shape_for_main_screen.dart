import 'package:flutter/material.dart';

class ShapeForMainScreen extends StatelessWidget {
  const ShapeForMainScreen({
    super.key,
    required this.angle,
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    final shapeWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Transform.rotate(
      angle: angle,
      child: CustomPaint(
        size: Size(shapeWidth, shapeWidth * (isPortrait ? 0.30 : 0.13)),
        painter: PaintForMainScreen(isDark: isDark),
      ),
    );
  }
}

class PaintForMainScreen extends CustomPainter {
  PaintForMainScreen({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = isDark
          ? const Color.fromARGB(255, 168, 123, 141)
          : const Color.fromRGBO(246, 168, 201, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.quadraticBezierTo(
        size.width * 1.0180000, size.height * -0.0714815, size.width, 0);
    path0.cubicTo(
        size.width * 0.8120000,
        size.height * 1.2833333,
        size.width * 0.1860000,
        size.height * 1.2940741,
        0,
        size.height * 0.0029630);
    path0.quadraticBezierTo(0, size.height * 0.0022222, 0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
