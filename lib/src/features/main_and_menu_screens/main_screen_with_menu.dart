import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';
import 'menu_screen.dart';
import 'main_screen_state_provider.dart';

import '../breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/starting_self_check_screen.dart';

class MainScreenWithDrawer extends StatelessWidget {
  const MainScreenWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainScreenState>(context, listen: false);

    // Check if the app was opened from a notification
    final notificationAppLaunchDetails =
        FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();

    notificationAppLaunchDetails
        .timeout(const Duration(milliseconds: 50))
        .then((notificationDetails) {
      final didNotificationLaunchApp =
          notificationDetails?.didNotificationLaunchApp;

      if (didNotificationLaunchApp != null &&
          didNotificationLaunchApp == true &&
          !provider.didLunchSelfCheckScreenOnce) {
        provider.setAsAlreadyLunchedSelfCheckScreenOnce();

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const StartingSelfCheckScreen(),
        ));
      }
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
