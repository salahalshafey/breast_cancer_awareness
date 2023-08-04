import 'package:flutter/material.dart';

import '../pages/home_screen.dart';
import 'custom_texts.dart';

class AwarenessTitle extends StatelessWidget {
  const AwarenessTitle(this.awarenessInfo, {super.key});

  final AwarenessInfo awarenessInfo;

  @override
  Widget build(BuildContext context) {
    final availableScreenWidth = MediaQuery.of(context).size.width - 70;

    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  awarenessInfo.image,
                  width: availableScreenWidth / 2,
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(
                width: availableScreenWidth / 2,
                child: TextNormal(data: awarenessInfo.title, fontSize: 20),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "LEARN MORE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
