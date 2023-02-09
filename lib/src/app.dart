import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Color get _myPrimaryColor => Colors.blue[900]!;
  Color get _mysecondaryColor => Colors.blue[700]!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            backgroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
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
            foregroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
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
            foregroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
          ),
        ),
        dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: _myPrimaryColor),
      ),
      home: const MainScreen(),
      routes: {},
    );
  }
}
