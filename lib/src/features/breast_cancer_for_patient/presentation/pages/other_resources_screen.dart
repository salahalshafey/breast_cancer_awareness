import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      title: "Tips for translation",
      content:
          "* **Access Chrome Menu:** In the top-right corner, you'll find three dots (Menu). Tap on them to open the menu.\n"
          "* **Select \"Translate\":** Look for the \"Translate\" option in the menu. Tap on it.\n"
          "* **Enable Translation:** Toggle the switch to enable translation for the website. Chrome will automatically detect the language of the web page and ask if you want to translate it.\n"
          "* **Confirm Translation:** A pop-up will appear asking if you want to translate the page. Tap on \"Translate\" to confirm.",
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
          tooltip: "Show Tips",
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
          "GIF to explain the above",
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
                      "error happened, couldn't load the GIF",
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
