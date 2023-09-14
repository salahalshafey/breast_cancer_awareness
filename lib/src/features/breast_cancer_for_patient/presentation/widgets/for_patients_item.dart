import 'package:flutter/material.dart';

import '../../../../core/util/widgets/custom_card.dart';

class ForPatientsItem extends StatelessWidget {
  const ForPatientsItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final String image;
  final String title;
  final String subTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subTitle, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
