import 'dart:math';

import 'package:flutter/material.dart';

import '../../../features/account/presentation/widgets/backgroud_shapes/profile_screen_shapes.dart';
import '../../../features/account/presentation/widgets/backgroud_shapes/second_sign_up_screen_shapes.dart';
import '../../../features/account/presentation/widgets/icon_from_asset.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({
    super.key,
    this.containingAppBar = true,
    this.appBartitle,
    this.containingBackgroundCancerSympol = true,
    required this.child,
  });

  final bool containingAppBar;
  final String? appBartitle;
  final bool containingBackgroundCancerSympol;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: containingAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              title: appBartitle == null ? null : Text(appBartitle!),
            )
          : null,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: -30,
            child: containingBackgroundCancerSympol
                ? const IconFromAsset(
                    assetIcon: "assets/images/background_cancer_sympol.png",
                    iconHeight: 150,
                    opacity: 0.62,
                  )
                : const SizedBox(),
          ),
          const Positioned(
            right: 0,
            bottom: 40,
            child: ShapeForProfileScreen(),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: ShapeForSecondSignUpScreen(
              angle: pi,
              widthFactor: 0.30,
            ),
          ),
          const Positioned(
            top: -20,
            left: -20,
            child: ShapeForSecondSignUpScreen(
              angle: -pi / 2,
              widthFactor: 0.30,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
