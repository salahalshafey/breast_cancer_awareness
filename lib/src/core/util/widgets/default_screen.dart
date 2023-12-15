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
    this.appBarbackgroundColor = Colors.transparent,
    this.appBarLeading,
    this.appBarActions,
    this.containingBackgroundCancerSympol = true,
    this.containingBackgroundRightSympol = true,
    required this.child,
  });

  final bool containingAppBar;
  final String? appBartitle;
  final Color appBarbackgroundColor;
  final Widget? appBarLeading;
  final List<Widget>? appBarActions;
  final bool containingBackgroundCancerSympol;
  final bool containingBackgroundRightSympol;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      //resizeToAvoidBottomInset: false,
      appBar: containingAppBar
          ? AppBar(
              backgroundColor: appBarbackgroundColor,
              title: appBartitle == null
                  ? null
                  : FittedBox(child: Text(appBartitle!)),
              actions: appBarActions,
              leading: appBarLeading,
            )
          : null,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: -30 - keyboardHeight,
            child: containingBackgroundCancerSympol
                ? const IconFromAsset(
                    assetIcon: "assets/images/background_cancer_sympol.png",
                    iconHeight: 150,
                    opacity: 0.62,
                  )
                : const SizedBox(),
          ),
          containingBackgroundRightSympol
              ? Positioned(
                  bottom: 40 - keyboardHeight,
                  left: Directionality.of(context) == TextDirection.rtl
                      ? 0
                      : null,
                  right: Directionality.of(context) == TextDirection.ltr
                      ? 0
                      : null,
                  child: const ShapeForProfileScreen(),
                )
              : const SizedBox(),
          Positioned(
            bottom: 0 - keyboardHeight,
            left: Directionality.of(context) == TextDirection.ltr ? 0 : null,
            right: Directionality.of(context) == TextDirection.rtl ? 0 : null,
            child: const ShapeForSecondSignUpScreen(
              angle: pi,
              widthFactor: 0.30,
            ),
          ),
          Positioned(
            top: -20,
            left: Directionality.of(context) == TextDirection.ltr ? -20 : null,
            right: Directionality.of(context) == TextDirection.rtl ? -20 : null,
            child: const ShapeForSecondSignUpScreen(
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
