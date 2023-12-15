import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/util/widgets/custom_card.dart';

import '../../../domain/entities/user_information.dart';
import '../get_user_type_with_localizations.dart';
import '../icon_from_asset.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({
    super.key,
    required this.userType,
    required this.changeUserType,
  });

  final UserTypes userType;
  final void Function(UserTypes userType) changeUserType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserType(
          userType: UserTypes.normal,
          userAssetIcon: "assets/icons/normal_user_icon.png",
          iconHeight: 50,
          isSelected: userType == UserTypes.normal,
          onTap: changeUserType,
        ),
        UserType(
          userType: UserTypes.doctor,
          userAssetIcon: "assets/icons/doctor_icon.png",
          iconHeight: 66,
          isSelected: userType == UserTypes.doctor,
          onTap: changeUserType,
        ),
        UserType(
          userType: UserTypes.patient,
          userAssetIcon: "assets/icons/patient_icon.svg",
          iconHeight: 50,
          isSelected: userType == UserTypes.patient,
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

  final UserTypes userType;
  final String userAssetIcon;
  final double iconHeight;
  final bool isSelected;
  final void Function(UserTypes userType) onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDoctor = userType == UserTypes.doctor;

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
              getuserTypeWithLocalizations(userType),
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
