import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'core/theme/colors.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

import 'features/main_and_menu_screens/main_screen.dart';
import 'features/main_and_menu_screens/main_screen_with_menu.dart';
import 'features/settings/providers/theme_provider.dart';

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

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorKey = _navigatorKey;
    final currentThemeMode = Provider.of<ThemeProvider>(context).themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Breast Cancer Awareness',
      theme: myLightTheme(),
      darkTheme: myDarkTheme(),
      themeMode: currentThemeMode,
      home: const LandingPage(),
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

        //  print(FirebaseAuth.instance.currentUser!.providerData.first.providerId);

        /*  FacebookAuth.instance.getUserData().then((data) {
          print(data);
        });*/

        /*  print(userSnapshot.data!.displayName);
        print(userSnapshot.data!.email);
        print(userSnapshot.data!.emailVerified);
        print(userSnapshot.data!.photoURL);
        print(userSnapshot.data!.providerData.first);*/

        /*  UserInfo(
          displayName: "Lio Rofakoko",
          email: "liorofakoko@gmail.com",
          phoneNumber: null,
          photoURL:
              "https://lh3.googleusercontent.com/a/ACg8ocL0P2ObSOWOLo_BniRlw7yI8c-mFrVfqxDzHqpm0i64=s96-c",
          providerId: "google.com",
          uid: "114805642639197595127",
        );*/

        /* UserInfo(
          displayName: "Salah Alshafey",
          email: "salahalshafey@gmail.com",
          phoneNumber: null,
          photoURL: "https://graph.facebook.com/6965357660190426/picture",
          providerId: "facebook.com",
          uid: "6965357660190426",
        );
        
        final facebookMap = {
          "name": "Salah Alshafey",
          "email": "salahalshafey@gmail.com",
          "picture": {
            "data": {
              "height": 200,
              "is_silhouette": false,
              "url":
                  "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=6965357660190426&width=200&ext=1702912119&hash=AeSxdoI3pjLrN07qLaM",
              "width": 200
            }
          },
          "id": 6965357660190426
        };*/

        /* UserInfo(
          displayName: "eslam alshafey",
          email: "eslamalshafey1321@gmail.com",
          phoneNumber: null,
          photoURL:
              "https://pbs.twimg.com/profile_images/1726740842088476672/WA64l-s7_normal.jpg",
          providerId: "twitter.com",
          uid: "1600606062025052278",
        );*/

        /*  print(
          userSnapshot.data!.metadata.creationTime!
              .difference(DateTime.now())
              .inSeconds
              .abs(),
        );

        print(userSnapshot.data!.uid);*/

        return const MainScreenWithDrawer();
      },
    );
  }
}
