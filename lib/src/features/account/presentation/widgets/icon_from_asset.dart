import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconFromAsset extends StatelessWidget {
  const IconFromAsset({
    super.key,
    required this.assetIcon,
    required this.iconHeight,
  });

  final String assetIcon;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}
