import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class InfoWithIcon extends StatelessWidget {
  const InfoWithIcon({
    super.key,
    required this.icon,
    required this.info,
    this.textAlign,
    this.textDirection,
    this.tooltip,
  });

  final Widget icon;
  final String info;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Tooltip(
                message: tooltip ?? "",
                textAlign: TextAlign.center,
                child: Text(
                  info,
                  textAlign: textAlign,
                  textDirection: textDirection,
                  style: const TextStyle(
                    color: MyColors.tetraryColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
