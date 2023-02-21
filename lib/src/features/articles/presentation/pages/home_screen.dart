import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          SizedBox(height: 20),
          Text(
            "General Information About Breast Cancer Awareness like: ",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "- Medical Articles.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "- Ways to reduce or prevent breast cancer.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "- How to examine yourself for breast cancer etc...",
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
