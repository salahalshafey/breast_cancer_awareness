import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../account/presentation/widgets/icon_from_asset.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onSelected,
    required this.currentSelectedIndex,
  });

  final void Function(int index) onSelected;
  final int currentSelectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIcon(
            index: 0,
            assetIcon: const IconFromAsset(
              assetIcon: "assets/icons/home_icon.svg",
              iconHeight: 45,
            ),
            isSelected: currentSelectedIndex == 0,
            onTap: onSelected,
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: CustomIcon(
              index: 1,
              assetIcon: const IconFromAsset(
                assetIcon: "assets/icons/doctor_icon.png",
                iconHeight: 70,
              ),
              isSelected: currentSelectedIndex == 1,
              onTap: onSelected,
            ),
          ),
          CustomIcon(
            index: 2,
            assetIcon: const IconFromAsset(
              assetIcon: "assets/icons/patient_icon.svg",
              iconHeight: 40,
            ),
            isSelected: currentSelectedIndex == 2,
            onTap: onSelected,
          ),
        ],
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.index,
    required this.assetIcon,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final IconFromAsset assetIcon;
  final bool isSelected;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: assetIcon.assetIcon.contains("patient")
          ? const BoxDecoration(
              color: Color.fromRGBO(190, 215, 255, 1),
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(color: Colors.white)),
            )
          : null,
      child: IconButton(
        icon: assetIcon,
        onPressed: () => onTap(index),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scaleXY(end: 1.1, duration: 250.ms)
        .fade(begin: 0.47, end: 1);
  }
}
