import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../app.dart';
import '../../../../../core/util/widgets/default_screen.dart';

import '../../../../account/presentation/widgets/icon_from_asset.dart';
import '../../widgets/custom_texts.dart';

class ShouldLookForScreen extends StatelessWidget {
  const ShouldLookForScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      child: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
        children: [
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.whatToLookFor,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          ..._thingsToLookFor().map((thingToLookFor) => ShouldLookForItem(
                thingToLookFor.title,
                thingToLookFor.image,
                thingToLookFor.description,
              )),
          const IconFromAsset(
            assetIcon: "assets/images/background_cancer_sympol.png",
            iconHeight: 150,
            opacity: 0.62,
          ),
        ].animate(interval: 200.ms).fade().moveX(
              begin: Directionality.of(context) == TextDirection.ltr ? -15 : 15,
              end: 0,
            ),
      ),
    );
  }
}

class ShouldLookForItem extends StatelessWidget {
  const ShouldLookForItem(
    this.title,
    this.image,
    this.description, {
    super.key,
  });

  final String title;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextTitle(data: title, fontSize: 24),
        const SizedBox(height: 20),
        Image.asset(image),
        const SizedBox(height: 20),
        TextNormal(data: description, fontSize: 22),
        const SizedBox(height: 40),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////// that data used for should look for screen ///////////////////
////////////////////////////////////////////////////////////////////////////////

class ThingToLookFor {
  final String title;
  final String image;
  final String description;

  const ThingToLookFor(this.title, this.image, this.description);
}

List<ThingToLookFor> _thingsToLookFor() {
  final context = navigatorKey.currentContext!;

  return [
    ThingToLookFor(
      AppLocalizations.of(context)!.lumpsKnotsThickenings,
      "assets/breast_cancer/look_for_1.jpeg",
      AppLocalizations.of(context)!.lumpsKnotsThickeningsDetails,
    ),
    ThingToLookFor(
      AppLocalizations.of(context)!.changesInSizeOrShape,
      "assets/breast_cancer/look_for_2.jpeg",
      AppLocalizations.of(context)!.changesInSizeOrShapeDetails,
    ),
    ThingToLookFor(
      AppLocalizations.of(context)!.nippleDischarge,
      "assets/breast_cancer/look_for_3.jpeg",
      AppLocalizations.of(context)!.nippleDischargeDetails,
    ),
    ThingToLookFor(
      AppLocalizations.of(context)!.skinChanges,
      "assets/breast_cancer/look_for_4.jpeg",
      AppLocalizations.of(context)!.skinChangesDetails,
    ),
  ];
}
