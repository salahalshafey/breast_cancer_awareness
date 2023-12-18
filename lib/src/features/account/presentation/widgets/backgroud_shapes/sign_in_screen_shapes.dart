import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Widget> singInBackGroundShapes(BuildContext context) {
  final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

  return [
    Positioned(
      top: -205,
      right: Directionality.of(context) == TextDirection.ltr ? -65 : null,
      left: Directionality.of(context) == TextDirection.rtl ? -65 : null,
      child: Transform.flip(
        flipX: Directionality.of(context) == TextDirection.rtl,
        child: Opacity(
          opacity: 0.58,
          child: SvgPicture.asset(
            "assets/images/background_flower.svg",
            height: 350,
          ),
        ),
      ),
    ),
    Positioned(
      bottom: -14 - keyboardHeight,
      right: Directionality.of(context) == TextDirection.rtl ? -165 : null,
      left: Directionality.of(context) == TextDirection.ltr ? -165 : null,
      child: Transform.flip(
        flipX: Directionality.of(context) == TextDirection.rtl,
        child: Opacity(
          opacity: 0.58,
          child: SvgPicture.asset(
            "assets/images/background_flower.svg",
            height: 350,
          ),
        ),
      ),
    ),
    Positioned(
      bottom: -15 - keyboardHeight,
      right: Directionality.of(context) == TextDirection.ltr ? 5 : null,
      left: Directionality.of(context) == TextDirection.rtl ? 5 : null,
      child: Opacity(
        opacity: 0.48,
        child: Image.asset(
          "assets/images/background_cancer_sympol.png",
          height: 90,
          filterQuality: FilterQuality.high,
        ),
      ),
    ),
  ];
}
