import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/widgets/default_screen.dart';

import '../../../../account/presentation/widgets/icon_from_asset.dart';
import '../../../domain/entities/note.dart';
import '../../widgets/custom_texts.dart';
import 'notes_and_reminder_screen.dart';

class FindingsScreen extends StatelessWidget {
  static const routName = '/findings-screen';

  const FindingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultScreen(
        containingBackgroundCancerSympol: false,
        containingAppBar: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          children: [
            const SizedBox(height: 20),
            TextTitle(
              data: AppLocalizations.of(context)!.findings,
              fontSize: 24,
              color: const Color.fromRGBO(199, 40, 107, 1),
            ),
            const SizedBox(height: 20),
            TextNormal(
              data: AppLocalizations.of(context)!
                  .congratulationsItsGreatThatYouAreTakingCareOfYourHealth,
              fontSize: 22,
            ),
            const SizedBox(height: 50),
            FindingItem(
              title: AppLocalizations.of(context)!.allIsWell,
              assetIcon: "assets/breast_cancer/all_is_well.png",
              iconHeight: 60,
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  NotesAndReminderScreen.routName,
                  arguments: Findings.allIsWell,
                );
              },
            ),
            FindingItem(
              title: AppLocalizations.of(context)!.notSure,
              assetIcon: "assets/breast_cancer/not_sure.png",
              iconHeight: 60,
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  NotesAndReminderScreen.routName,
                  arguments: Findings.notSure,
                );
              },
            ),
            FindingItem(
              title: AppLocalizations.of(context)!.noticedSomething,
              assetIcon: "assets/breast_cancer/noticed_something.png",
              iconHeight: 60,
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  NotesAndReminderScreen.routName,
                  arguments: Findings.noticedSomething,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FindingItem extends StatelessWidget {
  const FindingItem({
    super.key,
    required this.title,
    required this.assetIcon,
    required this.iconHeight,
    this.onTap,
  });

  final String title;
  final String assetIcon;
  final double iconHeight;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      onTap: onTap,
      title: Row(
        children: [
          const SizedBox(width: 10),
          IconFromAsset(
            assetIcon: assetIcon,
            iconHeight: iconHeight,
            opacity: Theme.of(context).brightness == Brightness.dark ? 0.7 : 1,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: null,
            ),
          )
        ],
      ),
    );
  }
}
