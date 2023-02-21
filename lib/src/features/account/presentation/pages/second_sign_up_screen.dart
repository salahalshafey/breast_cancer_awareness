import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/image_and_user_type.dart';

import '../widgets/backgroud_shapes/second_sign_up_screen_shapes.dart';
import '../widgets/choose_image.dart';
import '../widgets/continue_and_skip_button.dart';
import '../widgets/select_user_type.dart';

class SecondSignUpScreen extends StatelessWidget {
  static const routName = '/sign-up2';

  const SecondSignUpScreen({super.key});

  double _horizantalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 15.0;
    if (screenWidth > 500) {
      horizantalPadding += (screenWidth - 500) / 2;
    }

    return horizantalPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ImageAndUserType>(
        create: (context) => ImageAndUserType(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 0,
              left: 0,
              child: ShapeForSecondSignUpScreen(
                angle: -pi / 2,
                widthFactor: 0.50,
              ),
            ),
            const Positioned(
              top: 0,
              right: 0,
              child: ShapeForSecondSignUpScreen(
                angle: 0,
                widthFactor: 0.33,
              ),
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: ShapeForSecondSignUpScreen(
                angle: pi / 2,
                widthFactor: 0.40,
              ),
            ),
            //  if (Theme.of(context).brightness == Brightness.light)
            Positioned(
              bottom: -30,
              child: Opacity(
                opacity: 0.48,
                child: Image.asset(
                  "assets/images/background_cancer_sympol.png",
                  height: 180,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.symmetric(
                horizontal: _horizantalPadding(context),
                vertical: 60,
              ),
              children: const [
                SizedBox(height: 20),
                ChooseImage(),
                SizedBox(height: 60),
                SelectUserTypeHeader(),
                SizedBox(height: 40),
                SellectUserType(),
                SizedBox(height: 60),
                ContinueAndskipButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelectUserTypeHeader extends StatelessWidget {
  const SelectUserTypeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(196, 143, 171, 0.22),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          "Select User Type",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
