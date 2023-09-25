import 'package:flutter/material.dart';

class BulletedList extends StatelessWidget {
  const BulletedList({
    super.key,
    this.bullet,
    required this.text,
    this.bulletMargin = const EdgeInsets.only(top: 8, right: 10, left: 20),
    this.textDirection,
  });

  final Widget? bullet;
  final Widget text;
  final EdgeInsetsGeometry bulletMargin;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: textDirection,
      children: [
        Padding(
          padding: bulletMargin,
          child: bullet ??
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
        ),
        Expanded(child: text),
      ],
    );
  }
}
