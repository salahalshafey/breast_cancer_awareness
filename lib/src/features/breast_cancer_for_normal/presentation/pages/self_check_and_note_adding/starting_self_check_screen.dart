import 'package:flutter/material.dart';

import '../../../../../core/util/widgets/default_screen.dart';

import '../../../../../core/util/builders/go_to_screen_with_slide_transition.dart';
import 'self_check_screen.dart';
import 'should_look_for_screen.dart';

class StartingSelfCheckScreen extends StatelessWidget {
  const StartingSelfCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        children: [
          const SizedBox(height: 20),
          const Text(
            "Self-Check",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Let yourself be guided by text and graphics Step by Step",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            height: 200,
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              "assets/breast_cancer/examination_3.jpeg",
              // fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 30),
          Align(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SelfCheckScreen.routName);
              },
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 40)),
              ),
              child: const Text(
                "START SELF-CHECK",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Align(
            child: TextButton(
              onPressed: () => goToScreenWithSlideTransition(
                context,
                const ShouldLookForScreen(),
              ),
              child: const Text(
                "WHAT SHOULD I LOOK FOR?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
