import 'dart:math';
import 'package:flutter/material.dart';

import '../account/presentation/widgets/icon_from_asset.dart';

import '../account/presentation/widgets/backgroud_shapes/second_sign_up_screen_shapes.dart';
import 'widgets/shape_for_menu_screen.dart';

import 'widgets/image_with_name.dart';
import 'widgets/menu_items.dart';
import 'widgets/log_out_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ShapeForMenuScreen(),
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            children: const [
              SizedBox(height: 50),
              ImageWithName(),
              SizedBox(height: 30),
              MenuItems(),
              SizedBox(height: 120),
              LogOutButton(),
              SizedBox(height: 70),
            ],
          ),
        ],
      ),
    );
  }
}
