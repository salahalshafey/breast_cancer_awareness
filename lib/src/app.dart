import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final _myPrimaryColor = const Color.fromRGBO(191, 76, 136, 1);
  final _mysecondaryColor = const Color.fromRGBO(223, 122, 175, 1);
  final _appBarForGroundColor = const Color.fromRGBO(90, 135, 208, 1);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => di.sl<Account>()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Breast Cancer Awareness',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: _myPrimaryColor).copyWith(
              primary: _myPrimaryColor,
              secondary: _mysecondaryColor,
            ),
            // primaryColor: _myPrimaryColor,
            //secondaryHeaderColor: _mysecondaryColor,
            useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: _mysecondaryColor.withOpacity(0.6),
              cursorColor: _mysecondaryColor,
              selectionHandleColor: _mysecondaryColor,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              foregroundColor: _appBarForGroundColor,
              titleTextStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: _appBarForGroundColor,
              ),
              //toolbarHeight: 100,

              systemOverlayStyle: SystemUiOverlayStyle().copyWith(
                statusBarColor: _mysecondaryColor.withOpacity(0.5),
                statusBarBrightness: Brightness.dark,
              ),

              /* shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                ),
              ),*/
            ),
            iconTheme: IconThemeData(color: _myPrimaryColor),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(22)),
              filled: true,
              fillColor: _mysecondaryColor,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
                backgroundColor:
                    MaterialStateProperty.all<Color>(_myPrimaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30)),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(_myPrimaryColor),
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                  fontSize: 20,
                )),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                ),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30)),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(_myPrimaryColor),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
              ),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
            ),
            // progressIndicatorTheme:
            // ProgressIndicatorThemeData(color: _myPrimaryColor),
          ),
          themeMode: ThemeMode.dark,
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
        );
      },
    );
  }
}
