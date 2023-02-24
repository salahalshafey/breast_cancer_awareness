import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

import '../account/presentation/widgets/backgroud_shapes/profile_screen_shapes.dart';
import '../account/presentation/widgets/backgroud_shapes/second_sign_up_screen_shapes.dart';
import '../account/presentation/widgets/icon_from_asset.dart';

class AboutScreen extends StatelessWidget {
  static const routName = '/profile';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
            padding: const EdgeInsets.only(
              right: 25,
              left: 25,
              top: 40,
              bottom: 110,
            ),
            children: const [
              SizedBox(height: 60),
              Text(
                "App Overview",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              SelectableText(
                "Will Provide a brief overview of the app, including what it does and how it can help users become more aware of breast cancer.\n\n"
                "Explain why we created the app and the problem it is trying to solve.\n\n"
                "Describe the target audience for the app, such as women over a certain age or those with a family history of breast cancer.\n\n"
                "Highlight the key features of the app, such as a breast cancer symptom checker, risk assessment questionnaire, and information about breast cancer screening.\n\n"
                "Data and Research: Explain the research and data behind the app, including how it was developed and what research studies or medical professionals contributed to its creation.\n\n"
                "Provide information on how users can contact us or find support if they have questions about the app or breast cancer.",
                textAlign: TextAlign.justify,
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
