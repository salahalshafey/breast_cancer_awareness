import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/features/settings/providers/theme_provider.dart';
import 'src/features/account/presentation/providers/account.dart';

import 'src/injection_container.dart' as di;

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()..initialize()),
        ChangeNotifierProvider(create: (ctx) => di.sl<Account>()),
      ],
      child: const MyApp(),
    ),
  );
}
