import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

const _myPrimaryColor = MyColors.primaryColor;
const _mysecondaryColor = MyColors.secondaryColor;
const _appBarForGroundColor = MyColors.appBarForGroundColor;

ThemeData myDarkTheme() {
  return ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: _myPrimaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 168, 123, 141),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      foregroundColor: _appBarForGroundColor,
      titleTextStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: _appBarForGroundColor,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
        statusBarColor: _mysecondaryColor.withOpacity(0.5),
        systemNavigationBarColor: Colors.black87,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: _mysecondaryColor.withOpacity(0.6),
      cursorColor: _mysecondaryColor,
      selectionHandleColor: _mysecondaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 20 /*, vertical: 5*/),
      border: OutlineInputBorder(
        borderSide: BorderSide(),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _mysecondaryColor),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _myPrimaryColor),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        //  overlayColor: const MaterialStatePropertyAll(Colors.white12),
        backgroundColor: WidgetStatePropertyAll(_myPrimaryColor),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 20,
          //  color: Colors.white,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
        ),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 5, horizontal: 30)),
      ),
    ),
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(_myPrimaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 20,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
        ),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 5, horizontal: 30)),
      ),
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(_myPrimaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
      ),
    ),
    //iconTheme: const IconThemeData(color: _myPrimaryColor),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: _myPrimaryColor),
  );
}
