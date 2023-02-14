import 'dart:io';

import 'package:breast_cancer_awareness/src/core/util/builders/image_picker.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/custom_card.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class SecondSignUpScreen extends StatefulWidget {
  static const routName = '/sign-up2';

  const SecondSignUpScreen({super.key});

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
  File? _image;
  String _sellectedUserType = "";

  void _sellectUserType(String userType) {
    setState(() {
      _sellectedUserType = userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final m = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: -30,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/images/background_cancer_sympol.png",
                scale: 1.3,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
            children: [
              const SizedBox(height: 50),
              _image == null
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/person_avatar.png",
                        scale: 1.5,
                        filterQuality: FilterQuality.high,
                      ),
                    )
                  : ImageContainer(
                      image: _image!.path,
                      imageSource: From.file,
                      radius: 100,
                      shape: BoxShape.circle,
                      fit: BoxFit.cover,
                      border: Border.all(
                        color: const Color.fromRGBO(203, 100, 140, 1),
                        width: 2,
                      ),
                      showHighlight: true,
                      showImageDialoge: true,
                    ),
              const SizedBox(height: 10),
              Align(
                child: ElevatedButton(
                  onPressed: () async {
                    final imageXFile = await myImagePicker(context);
                    if (imageXFile == null) {
                      return;
                    }

                    setState(() {
                      _image = File(imageXFile.path);
                    });
                  },
                  child: const Text("Choose Image"),
                ),
              ),
              const SizedBox(height: 40),
              SellectUserType(
                currentSellectedUser: _sellectedUserType,
                onSellected: _sellectUserType,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SellectUserType extends StatelessWidget {
  const SellectUserType({
    super.key,
    required this.onSellected,
    required this.currentSellectedUser,
  });

  final void Function(String sellectedUser) onSellected;
  final String currentSellectedUser;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 0.0;
    if (screenWidth > 400) {
      horizantalPadding = (screenWidth - 400) / 2;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizantalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserType(
            userType: "Normal",
            userAssetIcon: "assets/icons/normal_user_icon.png",
            iconHeight: 50,
            isSellected: currentSellectedUser == "Normal",
            onTap: onSellected,
          ),
          UserType(
            userType: "Doctor",
            userAssetIcon: "assets/icons/doctor_icon.png",
            iconHeight: 65,
            isSellected: currentSellectedUser == "Doctor",
            onTap: onSellected,
          ),
          UserType(
            userType: "Patient",
            userAssetIcon: "assets/icons/patient_icon.svg",
            iconHeight: 50,
            isSellected: currentSellectedUser == "Patient",
            onTap: onSellected,
          ),
        ],
      ),
    );
  }
}

class UserType extends StatelessWidget {
  const UserType({
    super.key,
    required this.userType,
    required this.userAssetIcon,
    required this.iconHeight,
    required this.isSellected,
    required this.onTap,
  });

  final String userType;
  final String userAssetIcon;
  final double iconHeight;
  final bool isSellected;
  final void Function(String userType) onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDoctor = userType == "Doctor";

    return Align(
      child: CustomCard(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        color: const Color.fromRGBO(229, 183, 207, 1),
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: Color.fromRGBO(112, 112, 112, 1)),
        elevation: 15,
        onTap: () => onTap(userType),
        child: Column(
          children: [
            Container(
              width: iconHeight + (isDoctor ? 0 : 10),
              padding: isDoctor ? null : const EdgeInsets.all(5),
              decoration: isDoctor
                  ? null
                  : const BoxDecoration(
                      color: Color.fromRGBO(190, 215, 255, 1),
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                          BorderSide(color: Colors.white)),
                    ),
              child: IconFromAsset(
                assetIcon: userAssetIcon,
                iconHeight: iconHeight,
              ),
            ),
            Text(
              userType,
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: isSellected ? 1 : 0)
        .scaleXY(end: 1.1, duration: 200.ms)
        .tint(color: primaryColor.withOpacity(0.3));
  }
}

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
