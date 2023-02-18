import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'features/settings/providers/theme_provider.dart';

import 'features/account/presentation/pages/sign_in_screen.dart';
import 'features/account/presentation/pages/first_sign_up_screen.dart';
import 'features/account/presentation/pages/second_sign_up_screen.dart';
import 'main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breast Cancer Awareness',
      theme: myLightTheme(),
      darkTheme: myDarkTheme(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: const HomeScreen(),
      routes: {
        SignInScreen.routName: (ctx) => const SignInScreen(),
        FirstSignUpScreen.routName: (ctx) => const FirstSignUpScreen(),
        SecondSignUpScreen.routName: (ctx) => const SecondSignUpScreen(),
        MainScreen.routName: (ctx) => const MainScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (!userSnapshot.hasData) {
          return const SignInScreen();
        } else if (userSnapshot.data!.metadata.creationTime!
                .difference(DateTime.now())
                .inSeconds
                .abs() <
            5) {
          return const SecondSignUpScreen();
        }

        return const MainScreen();
      },
    );
  }
}
