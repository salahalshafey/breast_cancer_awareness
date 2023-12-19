import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          Text(
            AppLocalizations.of(context)!.selfcheck,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!
                .letYourselfBeGuidedByTextAndGraphicsStepByStep,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
              child: Text(
                AppLocalizations.of(context)!.startSelfcheck,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
              child: Text(
                AppLocalizations.of(context)!.whatShouldILookFor,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
