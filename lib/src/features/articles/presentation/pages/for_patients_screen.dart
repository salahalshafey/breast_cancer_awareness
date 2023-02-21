import 'package:flutter/material.dart';

class ForPatientsScreen extends StatelessWidget {
  const ForPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: const [
          SizedBox(height: 50),
          Text(
            "The Features That Will Be Implemented In This Screen",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Text(
            "- Improve spirits for breast cancer patients.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "- Healthy life style for patients.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "- Nutrition, Fitness, etc...",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
