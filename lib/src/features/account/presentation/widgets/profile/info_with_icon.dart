import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class InfoWithIcon extends StatelessWidget {
  const InfoWithIcon({
    super.key,
    required this.icon,
    required this.info,
    this.textAlign,
    this.tooltip,
  });

  final Widget icon;
  final String info;
  final TextAlign? textAlign;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Tooltip(
        message: tooltip ?? "",
        textAlign: TextAlign.center,
        showDuration: const Duration(seconds: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 20),
            Text(
              info,
              textAlign: textAlign,
              style: const TextStyle(
                color: MyColors.tetraryColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
