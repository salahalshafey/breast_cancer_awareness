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
            if (Theme.of(context).brightness == Brightness.light)
              Positioned(
                bottom: -30,
                child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    "assets/images/background_cancer_sympol.png",
                    scale: 1.5,
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












/*class SellectUserType extends StatelessWidget {
  const SellectUserType({
    super.key,
    required this.onSelected,
    required this.currentSelectedUser,
  });

  final void Function(String sellectedUser) onSelected;
  final String currentSelectedUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserType(
          userType: "Normal",
          userAssetIcon: "assets/icons/normal_user_icon.png",
          iconHeight: 50,
          isSelected: currentSelectedUser == "Normal",
          onTap: onSelected,
        ),
        UserType(
          userType: "Doctor",
          userAssetIcon: "assets/icons/doctor_icon.png",
          iconHeight: 65,
          isSelected: currentSelectedUser == "Doctor",
          onTap: onSelected,
        ),
        UserType(
          userType: "Patient",
          userAssetIcon: "assets/icons/patient_icon.svg",
          iconHeight: 50,
          isSelected: currentSelectedUser == "Patient",
          onTap: onSelected,
        ),
      ],
    );
  }
}

class UserType extends StatelessWidget {
  const UserType({
    super.key,
    required this.userType,
    required this.userAssetIcon,
    required this.iconHeight,
    required this.isSelected,
    required this.onTap,
  });

  final String userType;
  final String userAssetIcon;
  final double iconHeight;
  final bool isSelected;
  final void Function(String userType) onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDoctor = userType == "Doctor";

    return Align(
      child: CustomCard(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        color: isSelected
            ? primaryColor
            : const Color.fromRGBO(229, 183, 207, 0.22),
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Color.fromRGBO(112, 112, 112, 1)),
        elevation: 0, //isSellected ? 20 : 15,
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
                color: isSelected ? Colors.white : primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scaleXY(end: 1.1, duration: 200.ms)
        .boxShadow(
          begin: BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(10, 10),
            blurRadius: 10,
          ),
          end: BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(15, 15),
            blurRadius: 15,
          ),
          borderRadius: BorderRadius.circular(30),
        );

    // .elevation(begin: 10, end: 17);
    //.tint(color: primaryColor.withOpacity(0.3));
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
*/


