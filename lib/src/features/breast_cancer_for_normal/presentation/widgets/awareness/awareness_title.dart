import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../pages/awareness/awareness_screen.dart';
import '../../pages/home_screen.dart';
import '../custom_texts.dart';
import '../../../../../core/util/builders/go_to_screen_with_slide_transition.dart';

class AwarenessTitle extends StatelessWidget {
  const AwarenessTitle(this.awarenessInfo, {super.key});

  final AwarenessInfo awarenessInfo;

  @override
  Widget build(BuildContext context) {
    final availableScreenWidth = MediaQuery.of(context).size.width - 70;

    return GestureDetector(
      onTap: () => goToScreenWithSlideTransition(
        context,
        AwarenessScreen(awarenessInfo),
        beginOffset: const Offset(0, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(
                  awarenessInfo.image,
                  width: availableScreenWidth / 2,
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(
                width: availableScreenWidth / 2,
                child: TextNormal(data: awarenessInfo.title, fontSize: 20),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () => goToScreenWithSlideTransition(
                context,
                AwarenessScreen(awarenessInfo),
                beginOffset: const Offset(0, 1),
              ),
              child: Text(
                AppLocalizations.of(context)!.learnMore,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
