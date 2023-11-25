import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/util/widgets/custom_card.dart';

import '../icon_from_asset.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({
    super.key,
    required this.userType,
    required this.changeUserType,
  });

  final String userType;
  final void Function(String userType) changeUserType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserType(
          userType: "Normal",
          userAssetIcon: "assets/icons/normal_user_icon.png",
          iconHeight: 50,
          isSelected: userType == "Normal",
          onTap: changeUserType,
        ),
        UserType(
          userType: "Doctor",
          userAssetIcon: "assets/icons/doctor_icon.png",
          iconHeight: 66,
          isSelected: userType == "Doctor",
          onTap: changeUserType,
        ),
        UserType(
          userType: "Patient",
          userAssetIcon: "assets/icons/patient_icon.svg",
          iconHeight: 50,
          isSelected: userType == "Patient",
          onTap: changeUserType,
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
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
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
  }
}
