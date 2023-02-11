import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/account/presentation/providers/Account.dart';

import 'features/account/presentation/pages/sign_in_screen.dart';
import 'features/account/presentation/pages/first_sign_up_screen.dart';
import 'features/account/presentation/pages/second_sign_up_screen.dart';

import 'main_screen.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Color get _myPrimaryColor => Colors.blue[900]!;
  Color get _mysecondaryColor => Colors.blue[700]!;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => di.sl<Account>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Breast Cancer Awareness',
        theme: ThemeData(
          primaryColor: _myPrimaryColor,
          secondaryHeaderColor: _mysecondaryColor,
          appBarTheme: AppBarTheme(
            color: _myPrimaryColor,
            centerTitle: true,
            /* shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),*/
          ),
          iconTheme: IconThemeData(color: _myPrimaryColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(_myPrimaryColor),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontSize: 17,
              )),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(_myPrimaryColor),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontSize: 17,
              )),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(_myPrimaryColor),
            ),
          ),
          dialogTheme: DialogTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: _myPrimaryColor),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (userSnapshot.hasData) {
                return const MainScreen();
              }
              return const SignInScreen();
            }),
        routes: {
          SignInScreen.routName: (ctx) => const SignInScreen(),
          FirstSignUpScreen.routName: (ctx) => const FirstSignUpScreen(),
          SecondSignUpScreen.routName: (ctx) => const SecondSignUpScreen(),
        },
      ),
    );
  }
}
