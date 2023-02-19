import 'package:flutter/material.dart';

import 'colors.dart';

const _myPrimaryColor = MyColors.primaryColor;
const _mysecondaryColor = MyColors.secondaryColor;
const _appBarForGroundColor = MyColors.appBarForGroundColor;

ThemeData myDarkTheme() {
  return ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: _myPrimaryColor,
    appBarTheme: const AppBarTheme(
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
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: _mysecondaryColor.withOpacity(0.6),
      cursorColor: _mysecondaryColor,
      selectionHandleColor: _mysecondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20 /*, vertical: 5*/),
      border: OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(22),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: _mysecondaryColor),
        borderRadius: BorderRadius.circular(22),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: _myPrimaryColor),
        borderRadius: BorderRadius.circular(22),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
        backgroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 20,
          //  color: Colors.white,
        )),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 5, horizontal: 30)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
        textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 20,
        )),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 5, horizontal: 30)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: _myPrimaryColor),
  );
}
