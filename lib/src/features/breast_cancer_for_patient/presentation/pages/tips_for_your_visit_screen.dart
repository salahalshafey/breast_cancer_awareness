import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app.dart';
import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/widgets/bulleted_list.dart';
import '../../../account/presentation/widgets/icon_from_asset.dart';

class TipsForYourVisit extends StatelessWidget {
  const TipsForYourVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      containingBackgroundRightSympol: false,
      child: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
        children: [
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.tipsForYourDoctorsVisit,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Image.asset("assets/breast_cancer/tips_for_page.png"),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!
                .tipsForThingsToSayDoAtYourDoctorsAppointment,
            style: const TextStyle(fontSize: 16),
          ),
          BulletedList(
            text: Text(
              AppLocalizations.of(context)!
                  .weWantToHelpProvideYouWithToolsToBeYourOwnHealthAdvocatenn,
              style: const TextStyle(fontSize: 16),
            ),
            bullet: const SizedBox(width: 5, height: 5),
          ),
          ...tips().map((tip) => BulletedList(
                text: Text(tip, style: const TextStyle(fontSize: 16)),
              )),
          const SizedBox(height: 20),
          const IconFromAsset(
            assetIcon: "assets/images/background_cancer_sympol.png",
            iconHeight: 150,
            opacity: 0.62,
          ),
        ].animate(interval: 100.ms).fade().moveX(
              begin: Directionality.of(context) == TextDirection.ltr ? -15 : 15,
              end: 0,
            ),
      ),
    );
  }
}

List<String> tips() {
  final context = navigatorKey.currentContext!;

  return [
    AppLocalizations.of(context)!.haveYourAppHandyToReferenceYourNotes,
    AppLocalizations.of(context)!.bringSomeoneWithYouToTakeNotesOrAskYourDoctor,
    AppLocalizations.of(context)!.askForPamphletsAndForTheirNotesToBePrintedOut,
    AppLocalizations.of(context)!.beEmpoweredToGetASecondOpinion,
  ];
}
