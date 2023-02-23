import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/features/settings/providers/theme_provider.dart';
import 'src/features/account/presentation/providers/account.dart';
import 'src/features/main_and_menu_screens/main_screen_state_provider.dart';
import 'src/features/breast_cancer_detection/presentation/providers/for_doctor_screen_state_provider.dart';

import 'src/injection_container.dart' as di;

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await di.init();

  final currentTheme = await initializeCurrentTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider(currentTheme)),
        ChangeNotifierProvider(create: (ctx) => di.sl<Account>()),
        ChangeNotifierProvider(create: (ctx) => MainScreenState()),
        ChangeNotifierProvider(create: (ctx) => ForDoctorScreenState()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<String> initializeCurrentTheme() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('theme') ?? 'system';
}
