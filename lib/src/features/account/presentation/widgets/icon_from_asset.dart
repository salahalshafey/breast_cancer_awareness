import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconFromAsset extends StatelessWidget {
  const IconFromAsset({
    super.key,
    required this.assetIcon,
    required this.iconHeight,
    this.rotationAngleInDegrees = 0,
    this.opacity = 1,
  });

  final String assetIcon;
  final double iconHeight;
  final double rotationAngleInDegrees;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final radiansAngle = rotationAngleInDegrees * pi / 180.0;

    return Transform.rotate(
      angle: radiansAngle,
      child: Opacity(
        opacity: opacity,
        child: Align(
          alignment: Alignment.topCenter,
          child: assetIcon.endsWith(".svg")
              ? SvgPicture.asset(
                  assetIcon,
                  height: iconHeight,
                )
              : Image.asset(
                  assetIcon,
                  height: iconHeight,
                  //filterQuality: FilterQuality.high,
                ),
        ),
      ),
    );
  }
}
