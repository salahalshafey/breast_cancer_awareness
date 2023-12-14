import 'package:flutter/material.dart';

class ShapeForSecondSignUpScreen extends StatelessWidget {
  const ShapeForSecondSignUpScreen({
    super.key,
    required this.widthFactor,
    required this.angle,
  });

  final double widthFactor;
  final double angle;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var shapeWidth = screenSize.width * widthFactor;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      shapeWidth = screenSize.height * widthFactor;
    }

    return Transform.flip(
      flipX: Directionality.of(context) == TextDirection.rtl,
      child: Transform.rotate(
        angle: angle,
        child: CustomPaint(
          size: Size(shapeWidth, shapeWidth),
          painter: PaintForSecondSignUpScreen(),
        ),
      ),
    );
  }
}

class PaintForSecondSignUpScreen extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromRGBO(246, 168, 201, 0.27)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(
        size.width * 0.3116667, size.height * 0.6123333, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
