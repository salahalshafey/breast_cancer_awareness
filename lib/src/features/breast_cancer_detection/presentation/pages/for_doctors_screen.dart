import 'package:flutter/material.dart';

import '../../../main_and_menu_screens/main_screen.dart';
import '../../../settings/widgets/set_theme_mode.dart';

class ForDoctorsScreen extends StatelessWidget {
  const ForDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: const [
          SizedBox(height: 50),
          SignOut(),
          SizedBox(height: 20),
          GetUserData(),
          SizedBox(height: 20),
          SetThemeMode(),
          SizedBox(height: 30),
          Text(
            "Pick a Medical Image of Breast Cancer Radiology of The Patient.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Text(
            "See The Result OR Prediction Using The Machine Learning Model.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Placeholder(fallbackHeight: 200),
        ],
      ),
    );
  }
}
