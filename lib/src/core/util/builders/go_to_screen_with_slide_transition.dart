import 'package:flutter/material.dart';

void goToScreenWithSlideTransition(
  BuildContext context,
  Widget screen, {
  Offset beginOffset = const Offset(1, 0),
}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  );
}