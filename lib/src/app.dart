import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'core/network/network_info.dart';
import 'core/theme/colors.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/util/builders/custom_alret_dialoge.dart';

import 'features/main_and_menu_screens/main_screen.dart';
import 'features/main_and_menu_screens/main_screen_with_menu.dart';
import 'features/settings/providers/settings_provider.dart';

import 'features/account/presentation/pages/sign_in_screen.dart';
import 'features/account/presentation/pages/send_password_reset_email_screen.dart';
import 'features/account/presentation/pages/first_sign_up_screen.dart';
import 'features/account/presentation/pages/second_sign_up_screen.dart';
import 'features/account/presentation/pages/profile_screen.dart';

import 'features/breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/findings_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/notes_and_reminder_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/self_check_screen.dart';

import 'features/breast_cancer_detection/presentation/pages/prediction_screen.dart';

late GlobalKey<NavigatorState> navigatorKey;

bool appCheckedForUpdate = false;

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorKey = _navigatorKey;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final currentThemeMode = settingsProvider.themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Breast Cancer Awareness',
      theme: myLightTheme(),
      darkTheme: myDarkTheme(),
      themeMode: currentThemeMode,
      home: appCheckedForUpdate
          ? const LandingPage()
          : const LandingPageWithUpdateChecking(),
      routes: {
        SignInScreen.routName: (ctx) => const SignInScreen(),
        SendPasswordResetEmailScreen.routName: (ctx) =>
            const SendPasswordResetEmailScreen(),
        FirstSignUpScreen.routName: (ctx) => const FirstSignUpScreen(),
        SecondSignUpScreen.routName: (ctx) => const SecondSignUpScreen(),
        MainScreen.routName: (ctx) => const MainScreen(),
        ProfileScreen.routName: (ctx) => const ProfileScreen(),
        PredictionScreen.routName: (ctx) => const PredictionScreen(),
        SelfCheckScreen.routName: (ctx) => const SelfCheckScreen(),
        FindingsScreen.routName: (ctx) => const FindingsScreen(),
        NotesAndReminderScreen.routName: (ctx) =>
            const NotesAndReminderScreen(),
      },
    );
  }
}

class LandingPageWithUpdateChecking extends StatelessWidget {
  const LandingPageWithUpdateChecking({super.key});

  @override
  Widget build(BuildContext context) {
    appCheckedForUpdate = true;

    return FutureBuilder(
      future: checkForUpdates(),
      builder: (ctx, snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const LandingPage();
        }

        final updatesInfo = snapshot.data!;
        final currentAppVersion = updatesInfo["current_version"] as String;
        final latestAppVersion = updatesInfo["latest_version"] as String;
        final forceUpdate = updatesInfo["force_update"] as bool;

        if (currentAppVersion < latestAppVersion && forceUpdate) {
          Future.delayed(Durations.short2, () {
            showCustomAlretDialog(
              context: ctx,
              constraints: const BoxConstraints(maxWidth: 500),
              canPopScope: false,
              barrierDismissible: false,
              title: "Need Update",
              content:
                  "App current version isn't supported enymore, You have to update "
                  "to the latest version.",
              actionsBuilder: (dialogeContext) => [
                ElevatedButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade900)),
                  child: const Text("Update"),
                ),
              ],
            );
          });
        } else if (currentAppVersion < latestAppVersion) {
          final titleColor = Theme.of(context).appBarTheme.foregroundColor;

          Future.delayed(Durations.short2, () {
            showCustomAlretDialog(
              context: ctx,
              constraints: const BoxConstraints(maxWidth: 500),
              titleColor: titleColor,
              title: "Update App?",
              content: "A new version of Breast Cancer Awareness is available! "
                  "Version $latestAppVersion is now available-you have $currentAppVersion.\n\n"
                  "Would you like to update it now?",
              actionsBuilder: (dialogeContext) => [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(dialogeContext).pop();
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(titleColor),
                    side: MaterialStatePropertyAll(
                        BorderSide(color: titleColor!)),
                  ),
                  child: const Text("Later"),
                ),
                ElevatedButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(titleColor)),
                  child: const Text("Update"),
                ),
              ],
            );
          });
        }

        return const LandingPage();
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MyColors.primaryColor.withOpacity(0.5),
      systemNavigationBarColor: Theme.of(context).brightness == Brightness.light
          ? MyColors.secondaryColor
          : Colors.black87,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (!userSnapshot.hasData) {
          return const SignInScreen();
        } else if (userSnapshot.data!.metadata.creationTime!
                    .difference(DateTime.now())
                    .inSeconds
                    .abs() <
                /*1246 +*/ 10 &&
            !userSnapshot.data!.isAnonymous) {
          return const SecondSignUpScreen();
        }

        return const MainScreenWithDrawer();
      },
    );
  }
}

//////////// used above /////////////////////////////
////////////////

Future<Map<String, dynamic>?> checkForUpdates() async {
  if (await NetworkInfoImpl().isNotConnected) {
    return null;
  }

  try {
    final document = await FirebaseFirestore.instance
        .collection('app_update')
        .doc('check_for_updates')
        .get();

    if (document.data() == null) {
      return null;
    }

    final currentAppVersion = (await PackageInfo.fromPlatform()).version;

    final updatesInfo = document.data()!
      ..addAll({"current_version": currentAppVersion});

    return updatesInfo;
  } catch (error) {
    return null;
  }
}

extension on String {
  bool operator <(String other) {
    final thisVersionNums =
        split(".").map((versionNum) => int.parse(versionNum));
    final otherVersionNums =
        other.split(".").map((versionNum) => int.parse(versionNum));

    final numOfIteration = min(thisVersionNums.length, otherVersionNums.length);

    for (int i = 0; i < numOfIteration; i++) {
      if (thisVersionNums.elementAt(i) < otherVersionNums.elementAt(i)) {
        return true;
      }
    }

    return false;
  }
}
