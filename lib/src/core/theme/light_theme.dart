import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const _myPrimaryColor = MyColors.primaryColor;
const _mysecondaryColor = MyColors.secondaryColor;
const _appBarForGroundColor = MyColors.appBarForGroundColor;

ThemeData myLightTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _myPrimaryColor).copyWith(
      primary: _myPrimaryColor,
      secondary: _mysecondaryColor,
    ),
    useMaterial3: true,

    textSelectionTheme: TextSelectionThemeData(
      selectionColor: _mysecondaryColor.withOpacity(0.6),
      cursorColor: _mysecondaryColor,
      selectionHandleColor: _mysecondaryColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromRGBO(246, 168, 201, 1),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: _appBarForGroundColor,
      titleTextStyle: const TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: _appBarForGroundColor,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
        statusBarColor: _mysecondaryColor.withOpacity(0.5),
        systemNavigationBarColor: MyColors.secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    iconTheme: const IconThemeData(color: _myPrimaryColor),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20 /*, vertical: 5*/),
      hintStyle: const TextStyle(color: Colors.white),
      /* border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(22),
          ),*/
      //isDense: true,
      // outlineBorder: BorderSide(color: _mysecondaryColor, width: 5),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(22),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(22),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(22),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(22),
      ),
      filled: true,
      fillColor: _mysecondaryColor,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.white12),
        backgroundColor: MaterialStateProperty.all<Color>(_myPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
          fontSize: 20,
          color: Colors.white,
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
    // progressIndicatorTheme:
    // ProgressIndicatorThemeData(color: _myPrimaryColor),
  );
}
