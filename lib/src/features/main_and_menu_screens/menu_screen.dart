import 'package:flutter/material.dart';

import 'main_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xfff6a8c9).withOpacity(0.27),
                  const Color(0xffff016f).withOpacity(0.27),
                  const Color(0xffff006f).withOpacity(0.27),
                ],
                stops: const [0, 0.423, 1],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "The Drawer Item Will Be Here",
                  style: TextStyle(fontSize: 25),
                ),
                SignOut(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
