import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app.dart';
import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/builders/custom_alret_dialog.dart';

import '../../../account/presentation/widgets/icon_from_asset.dart';
import '../widgets/resource_item.dart';

class OtherResourcesScreen extends StatelessWidget {
  const OtherResourcesScreen({super.key});

  void showTipDialog(BuildContext context) {
    showCustomAlretDialog(
      context: context,
      constraints: const BoxConstraints(maxWidth: 500),
      titleColor: Theme.of(context).appBarTheme.foregroundColor,
      title: AppLocalizations.of(context)!.tipsForTranslation,
      content: AppLocalizations.of(context)!.accessChromeMenuInstructions,
      contentWidget: const GifWithLoading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      containingBackgroundRightSympol: false,
      appBarActions: [
        IconButton(
          onPressed: () => showTipDialog(context),
          tooltip: AppLocalizations.of(context)!.showTips,
          icon: const Icon(Icons.tips_and_updates)
              .animate(
                onPlay: (controller) {
                  controller.loop(count: 10, reverse: true);
                },
                delay: 1400.ms,
              )
              .scaleXY(begin: 1, end: 1.3, duration: 500.ms),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
        children: [
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.otherResources,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Image.asset("assets/breast_cancer/other_resources_for_page.png"),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.takeALookAtSomeOtherHelpfulResources,
            style: const TextStyle(fontSize: 16),
          ),
          ...resources().map((resource) => ResourceItem(
                text: resource.text,
                actionText: resource.actionText,
                url: resource.url,
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

class Resource {
  final String text;
  final String actionText;
  final String url;

  const Resource({
    required this.text,
    required this.actionText,
    required this.url,
  });
}

List<Resource> resources() {
  final context = navigatorKey.currentContext!;

  return [
    Resource(
      text: AppLocalizations.of(context)!.support,
      actionText: AppLocalizations.of(context)!.youngSurvivalCoalition,
      url: "https://youngsurvival.org/",
    ),
    Resource(
      text: AppLocalizations.of(context)!.treatment,
      actionText: AppLocalizations.of(context)!.breastCancerTreatment,
      url: "https://www.cancer.gov/types/breast/patient/breast-treatment-pdq",
    ),
    Resource(
      text: AppLocalizations.of(context)!.childrenTreatment,
      actionText: AppLocalizations.of(context)!.childhoodBreastCancerTreatment,
      url:
          "https://www.cancer.gov/types/breast/patient/child-breast-treatment-pdq",
    ),
    Resource(
      text: AppLocalizations.of(context)!.duringPregnancy,
      actionText:
          AppLocalizations.of(context)!.breastCancerTreatmentDuringPregnancy,
      url:
          "https://www.cancer.gov/types/breast/patient/pregnancy-breast-treatment-pdq",
    ),
    Resource(
      text: AppLocalizations.of(context)!.forMales,
      actionText: AppLocalizations.of(context)!.maleBreastCancerTreatment,
      url:
          "https://www.cancer.gov/types/breast/patient/male-breast-treatment-pdq",
    ),
    Resource(
      text: AppLocalizations.of(context)!.screening,
      actionText: AppLocalizations.of(context)!.breastCancerScreening,
      url: "https://www.cancer.gov/types/breast/patient/breast-screening-pdq",
    ),
  ];
}

/////////////////////////////////////////////////////////
/////////////////////////////////
/////////////////

class GifWithLoading extends StatefulWidget {
  const GifWithLoading({
    super.key,
  });

  @override
  State<GifWithLoading> createState() => _GifWithLoadingState();
}

class _GifWithLoadingState extends State<GifWithLoading> {
  bool _showLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.gifToExplainTheAbove,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black54
                : Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            if (_showLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: CircularProgressIndicator(),
                ),
              ),
            Center(
              child: Image.network(
                "https://github.com/salahalshafey/breast_cancer_awareness/assets/64344500/c0f0593c-0d91-4e96-b74e-1915a18c5493",
                loadingBuilder: (ctx, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() => _showLoading = false);
                  });

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircularProgressIndicator(
                        value: loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!,
                      ),
                    ),
                  );
                },
                errorBuilder: (ctx, error, stk) {
                  /*  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() => _showLoading = false);
                  });*/

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 70),
                    child: Text(
                      AppLocalizations.of(context)!
                          .errorHappenedCouldntLoadTheGif,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black54
                            : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
