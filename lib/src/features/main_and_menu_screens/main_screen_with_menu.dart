import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'main_screen.dart';
import 'menu_screen.dart';

import 'widgets/opened_from_notification.dart';

class MainScreenWithDrawer extends StatelessWidget {
  const MainScreenWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Durations.short1, () {
      ifTheAppOpenedFromNotificationOpenSelfCheckScreen(context);
    });

    return ZoomDrawer(
      controller: ZoomDrawerController(),
      style: DrawerStyle.defaultStyle,
      menuScreen: const MenuScreen(),
      mainScreen: const MainScreen(),
      //dragOffset: 0,
      borderRadius: 24.0,
      androidCloseOnBackTap: true,
      angle: 0,
      slideWidth: MediaQuery.of(context).size.width * 0.85,
      mainScreenTapClose: true,
      moveMenuScreen: false,
      menuScreenWidth: MediaQuery.of(context).size.width,
      //openCurve: Curves.fastOutSlowIn,
      // closeCurve: Curves.bounceIn,
    );
  }
}
