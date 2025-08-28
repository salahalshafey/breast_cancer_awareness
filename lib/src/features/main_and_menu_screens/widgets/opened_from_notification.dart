import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/starting_self_check_screen.dart';
import '../main_screen_state_provider.dart';

void ifTheAppOpenedFromNotificationOpenSelfCheckScreen(
    BuildContext context) async {
  final provider = Provider.of<MainScreenState>(context, listen: false);

  // Check if the app was opened from a notification
  final notificationAppLaunchDetails =
      FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();

  notificationAppLaunchDetails.then((notificationDetails) {
    final didNotificationLaunchApp =
        notificationDetails?.didNotificationLaunchApp;

    if (didNotificationLaunchApp != null &&
        didNotificationLaunchApp == true &&
        !provider.didLunchSelfCheckScreenOnce) {
      provider.setAsAlreadyLunchedSelfCheckScreenOnce();

      if (!context.mounted) return;

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const StartingSelfCheckScreen(),
      ));
    }
  });
}
