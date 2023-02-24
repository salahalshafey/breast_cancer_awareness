import 'dart:math';

import 'package:breast_cancer_awareness/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../account/presentation/widgets/backgroud_shapes/profile_screen_shapes.dart';
import '../../account/presentation/widgets/backgroud_shapes/second_sign_up_screen_shapes.dart';

import '../../account/presentation/widgets/icon_from_asset.dart';
import '../widgets/set_theme_mode.dart';

class SettingsScreen extends StatelessWidget {
  static const routName = '/profile';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            bottom: -30,
            child: IconFromAsset(
              assetIcon: "assets/images/background_cancer_sympol.png",
              iconHeight: 150,
              opacity: 0.62,
            ),
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
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            children: const [
              SizedBox(height: 60),
              SetThemeMode(),
              SizedBox(height: 30),
              Text(
                "Language",
                style: TextStyle(
                  color: MyColors.tetraryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Notifications",
                style: TextStyle(
                  color: MyColors.tetraryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Search Engine",
                style: TextStyle(
                  color: MyColors.tetraryColor,
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
