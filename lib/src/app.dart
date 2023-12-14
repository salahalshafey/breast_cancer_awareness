import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/theme/colors.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

import 'features/account/presentation/pages/sign_in_screen.dart';
import 'features/account/presentation/pages/send_password_reset_email_screen.dart';
import 'features/account/presentation/pages/first_sign_up_screen.dart';
import 'features/account/presentation/pages/second_sign_up_screen.dart';
import 'features/account/presentation/pages/profile_screen.dart';

import 'features/breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/findings_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/notes_and_reminder_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/self_check_and_note_adding/self_check_screen.dart';

import 'features/breast_cancer_detection/presentation/pages/prediction_screen.dart';

import 'features/main_and_menu_screens/main_screen.dart';
import 'features/main_and_menu_screens/main_screen_state_provider.dart';
import 'features/main_and_menu_screens/main_screen_with_menu.dart';
import 'features/main_and_menu_screens/widgets/check_for_update.dart';

import 'features/settings/providers/settings_provider.dart';

late GlobalKey<NavigatorState> navigatorKey;

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorKey = _navigatorKey;

    final settingsProvider = Provider.of<SettingsProvider>(context);

    final currentThemeMode = settingsProvider.themeMode;
    final currentLocale = settingsProvider.currentLocale;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Breast Cancer Awareness',
      theme: myLightTheme(),
      darkTheme: myDarkTheme(),
      themeMode: currentThemeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale,
      home: const LandingPageWithCheckForUpdate(),
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

//////////////////////// landing pages ////////////////////////////
///////////////////
/////////

// check for updates only once
class LandingPageWithCheckForUpdate extends StatelessWidget {
  const LandingPageWithCheckForUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainScreenState>(context, listen: false);
    final updatesInfo = provider.updatesInfo;

    if (updatesInfo == null || provider.appCheckedForUpdate) {
      provider.setAsAlreadyCheckedForUpdate();

      return const LandingPage();
    }

    provider.setAsAlreadyCheckedForUpdate();

    final currentAppVersion = updatesInfo["current_version"] as String;
    final latestAppVersion = updatesInfo["latest_version"] as String;
    final versionToForceUpdateIfBelow =
        updatesInfo["force_update_versions_below"] as String;

    final forceUpdateAfter =
        (updatesInfo["force_update_after"] as Timestamp).toDate();
    final currentDateTime = updatesInfo["current_date_time"] as DateTime;

    if (currentAppVersion < versionToForceUpdateIfBelow &&
        currentDateTime.isAfter(forceUpdateAfter)) {
      changStatusAndSystemNavigationBarDynamicWithTheme(context);

      Future.delayed(Durations.short1, () {
        forcUpdateDialog(context);
      });

      return const Scaffold(
        body: Center(),
      );
    }

    if (currentAppVersion < versionToForceUpdateIfBelow) {
      final daysToUpdate = forceUpdateAfter.difference(currentDateTime).inDays;
      final daysToUpdateString = daysToUpdate == 0 || daysToUpdate == 1
          ? AppLocalizations.of(context)!.oneDay
          : daysToUpdate == 2
              ? AppLocalizations.of(context)!.twoDays
              : AppLocalizations.of(context)!.days(daysToUpdate);

      Future.delayed(const Duration(seconds: 2), () {
        forceUpdateAfterDaysDialog(context, daysToUpdateString);
      });

      return const LandingPage();
    }

    if (currentAppVersion < latestAppVersion) {
      Future.delayed(const Duration(seconds: 2), () {
        selectiveUpdateDialog(context, latestAppVersion, currentAppVersion);
      });

      return const LandingPage();
    }

    return const LandingPage();
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    changStatusAndSystemNavigationBarDynamicWithTheme(context);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (!userSnapshot.hasData) {
          return const SignInScreen();
        }

        if (userSnapshot.data!.metadata.creationTime!
                    .difference(DateTime.now())
                    .inSeconds
                    .abs() <
                10 &&
            !userSnapshot.data!.isAnonymous) {
          return const SecondSignUpScreen();
        }

        final settingsProvider = Provider.of<SettingsProvider>(context);

        print(settingsProvider.currentLanguageCode);

        return const MainScreenWithDrawer();
      },
    );
  }
}

void changStatusAndSystemNavigationBarDynamicWithTheme(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: MyColors.primaryColor.withOpacity(0.5),
    systemNavigationBarColor: Theme.of(context).brightness == Brightness.light
        ? MyColors.secondaryColor
        : Colors.black87,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
}
