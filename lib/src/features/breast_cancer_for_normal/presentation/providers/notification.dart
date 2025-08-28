// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:provider/provider.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../app.dart';
import '../../../main_and_menu_screens/main_screen_state_provider.dart';
import '../pages/self_check_and_note_adding/starting_self_check_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void print2(NotificationResponse details) {
  // print(navigatorKey);
}

class Noti {
  static Future<void> initialize() async {
    const androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');
    const iOSInitialize = DarwinInitializationSettings();

    const initializationsSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (details) {
        final context = navigatorKey.currentContext!;

        // print(navigatorKey);

        final provider = Provider.of<MainScreenState>(context, listen: false);
        provider.setAsAlreadyLunchedSelfCheckScreenOnce();

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const StartingSelfCheckScreen()));
      },
      onDidReceiveBackgroundNotificationResponse: print2,
    );
  }

  static Future<void> showBigTextNotification({
    int id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'you_can_name_it_whatever5',
      'channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // it will be every 2 weeks, the reason that I changed the pub.dev file:
    // C:\Users\salah alaa\AppData\Local\Pub\Cache\hosted\pub.dev\flutter_local_notifications-15.1.0+1\android\src\main\java\com\dexterous\flutterlocalnotifications
    // in the file 'FlutterLocalNotificationsPlugin.java' line 744
    // C:\Users\salah alaa\AppData\Local\Pub\Cache\hosted\pub.dev\flutter_local_notifications-15.1.0+1\ios\Classes
    // in the file 'FlutterLocalNotificationsPlugin.m' line 745

    flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.weekly, // it will be every 2 weeks
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}










    // print(currentTimeZone);

    //print(tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)));

    /*final scheduledDate = DateTime.now()
        .copyWith(
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        )
        .add(const Duration(days: 14));

    tz.TZDateTime.from(scheduledDate, tz.getLocation(currentTimeZone));*/

    /*await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );*/
