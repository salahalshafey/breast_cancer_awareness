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

    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromRGBO(246, 168, 201, 1),
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
        systemNavigationBarColor: MyColors.secondaryColor,
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
      hintStyle: TextStyle(color: Colors.white),
      /* border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(22),
          ),*/
      //isDense: true,
      // outlineBorder: BorderSide(color: _mysecondaryColor, width: 5),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      filled: true,
      fillColor: _mysecondaryColor,
    ),

    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.white12),
        backgroundColor: WidgetStatePropertyAll(_myPrimaryColor),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 20,
          color: Colors.white,
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
        side: WidgetStatePropertyAll(BorderSide(color: _myPrimaryColor)),
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

    iconTheme: const IconThemeData(color: _myPrimaryColor),

    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
    ),
    // progressIndicatorTheme:
    // ProgressIndicatorThemeData(color: _myPrimaryColor),
  );
}
