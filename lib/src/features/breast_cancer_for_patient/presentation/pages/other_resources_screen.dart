import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/builders/custom_alret_dialoge.dart';

import '../../../account/presentation/widgets/icon_from_asset.dart';
import '../widgets/resource_item.dart';

class OtherResourcesScreen extends StatelessWidget {
  const OtherResourcesScreen({super.key});

  void showTipDialog(BuildContext context) {
    showCustomAlretDialog(
      context: context,
      title: "Tip for translation",
      content: "Tip for translating the web pages",
      titleColor: Theme.of(context).appBarTheme.foregroundColor,
      contentWidget: Center(
        child: Image.asset("assets/breast_cancer/other_resources_for_page.png"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      containingBackgroundRightSympol: false,
      actions: [
        IconButton(
          onPressed: () => showTipDialog(context),
          tooltip: "Show Tip",
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
          const Text(
            "Other Resources",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Image.asset("assets/breast_cancer/other_resources_for_page.png"),
          const SizedBox(height: 20),
          const Text(
            "Take a look at some other helpful resources\n",
            style: TextStyle(fontSize: 16),
          ),
          ...resources.map((resource) => ResourceItem(
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
        ].animate(interval: 100.ms).fade().moveX(),
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

List<Resource> resources = const [
  Resource(
    text: "Support: ",
    actionText: "Young Survival Coalition\n",
    url: "https://youngsurvival.org/",
  ),
  Resource(
    text: "Treatment: ",
    actionText: "Breast Cancer Treatment\n",
    url: "https://www.cancer.gov/types/breast/patient/breast-treatment-pdq",
  ),
  Resource(
    text: "Children Treatment: ",
    actionText: "Childhood Breast Cancer Treatment\n",
    url:
        "https://www.cancer.gov/types/breast/patient/child-breast-treatment-pdq",
  ),
  Resource(
    text: "During Pregnancy: ",
    actionText: "Breast Cancer Treatment During Pregnancy\n",
    url:
        "https://www.cancer.gov/types/breast/patient/pregnancy-breast-treatment-pdq",
  ),
  Resource(
    text: "For Males: ",
    actionText: "Male Breast Cancer Treatment\n",
    url:
        "https://www.cancer.gov/types/breast/patient/male-breast-treatment-pdq",
  ),
  Resource(
    text: "Screening: ",
    actionText: "Breast Cancer Screening\n",
    url: "https://www.cancer.gov/types/breast/patient/breast-screening-pdq",
  ),
];
