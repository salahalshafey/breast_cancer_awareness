import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:wakelock/wakelock.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'firebase_options.dart';

import 'src/features/main_and_menu_screens/widgets/check_for_update.dart';
import 'src/features/settings/providers/settings_provider.dart';
import 'src/features/account/presentation/providers/account.dart';
import 'src/features/breast_cancer_for_normal/presentation/providers/notes.dart';
import 'src/features/breast_cancer_for_patient/presentation/providers/search.dart';
import 'src/features/main_and_menu_screens/main_screen_state_provider.dart';
import 'src/features/breast_cancer_detection/presentation/providers/for_doctor_screen_state_provider.dart';

import 'src/injection_container.dart' as di;

import 'src/app.dart';

void main() async {
  // to show splash screen for 2 more seconds
  // await Future.delayed(const Duration(seconds: 2));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  /*await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  );*/

  await di.init();

  final settings = await initializeSettings();

  final updatesInfo = await checkForAnyUpdates();

  await langdetect.initLangDetect();

  //Wakelock.enable();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SettingsProvider(settings)),
        ChangeNotifierProvider(create: (ctx) => MainScreenState(updatesInfo)),
        ChangeNotifierProvider(create: (ctx) => di.sl<Account>()),
        ChangeNotifierProvider(create: (ctx) => di.sl<Notes>()),
        ChangeNotifierProvider(create: (ctx) => di.sl<Search>()),
        ChangeNotifierProvider(create: (ctx) => ForDoctorScreenState()),
      ],
      child: MyApp(),
    ),
  );
}

Future<Settings> initializeSettings() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final settingsString = prefs.getString('settings');

  if (settingsString == null) {
    return Settings.defaultValues();
  }

  return Settings.fromJson(jsonDecode(settingsString));
}
