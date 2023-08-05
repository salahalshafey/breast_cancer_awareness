import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../account/presentation/widgets/backgroud_shapes/profile_screen_shapes.dart';
import '../../../account/presentation/widgets/backgroud_shapes/second_sign_up_screen_shapes.dart';
import '../../../account/presentation/widgets/icon_from_asset.dart';
import '../widgets/awareness_video_or_image.dart';
import 'home_screen.dart';

class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen(this.awarenessInfo, {super.key});

  final AwarenessInfo awarenessInfo;

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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            children: [
              // const SizedBox(height: 60),
              AwarenessVideoOrImage(
                image: awarenessInfo.image,
                videoLink: awarenessInfo.videoLink,
              ),
              const SizedBox(height: 20),
              Text(
                awarenessInfo.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromRGBO(199, 40, 107, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                awarenessInfo.description,
                textAlign: TextAlign.justify,
                textDirection: firstCharIsArabic(awarenessInfo.description)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
