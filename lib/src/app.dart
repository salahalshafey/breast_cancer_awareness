import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'core/theme/colors.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

import 'features/account/presentation/pages/sign_in_screen.dart';
import 'features/account/presentation/pages/first_sign_up_screen.dart';
import 'features/account/presentation/pages/second_sign_up_screen.dart';
import 'features/account/presentation/pages/profile_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/findings_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/notes_and_reminder_screen.dart';
import 'features/main_and_menu_screens/main_screen.dart';
import 'features/breast_cancer_detection/presentation/pages/prediction_screen.dart';
import 'features/breast_cancer_for_normal/presentation/pages/self_check_screen.dart';

import 'features/main_and_menu_screens/main_screen_with_menu.dart';
import 'features/settings/providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = Provider.of<ThemeProvider>(context).themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breast Cancer Awareness',
      theme: myLightTheme(),
      darkTheme: myDarkTheme(),
      themeMode: currentThemeMode,
      home: const LandingPage(),
      routes: {
        SignInScreen.routName: (ctx) => const SignInScreen(),
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
            5) {
          return const SecondSignUpScreen();
        }

        return const MainScreenWithDrawer();
      },
    );
  }
}
