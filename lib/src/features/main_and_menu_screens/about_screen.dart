import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/util/widgets/bulleted_list.dart';
import '../../core/util/widgets/default_screen.dart';
import '../../core/theme/colors.dart';
import '../../core/util/widgets/text_well_formatted.dart';

import '../../core/util/widgets/text_with_action_text.dart';
import '../account/presentation/widgets/icon_from_asset.dart';

class AboutScreen extends StatelessWidget {
  static const routName = '/profile';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      child: ListView(
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          top: 100,
          bottom: 50,
        ),
        children: [
          const Text(
            "App Overview",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const TextWellFormattedWithBulleted(
            data:
                "**Breast Cancer Awareness app** is a comprehensive tool designed to raise awareness and promote early detection of breast cancer. "
                "It addresses four key aspects: providing `information and awareness`, facilitating `self-examination` through a symptom checker, assisting doctors with `deep learning models` for detection, and offering support `resources` and `guidance` for patients.\n"
                "* **Purpose:** The app was created with the primary goal of empowering individuals to take charge of their breast health. "
                "By amalgamating information, self-examination tools, advanced detection models, and supportive resources, we aim to contribute to the early detection and management of breast cancer.\n"
                "* **Target Audience:** Our target audience spans a wide range, including individuals of all genders interested in breast health awareness, those performing self-examinations, medical professionals seeking advanced diagnostic tools, and patients in need of support and guidance.\n\n"
                "**Key Features**\n"
                "* **Information Hub:** Accessible `information` on breast cancer, its symptoms, risk factors, and preventive measures.\n"
                "* **Symptom Checker:** An interactive `self-examination` tool guiding users through the detection of potential symptoms.\n"
                "* **Deep Learning Models:** Advanced AI models for doctors, aiding in the detection of breast cancer from `mammogram` and `histopathology` images.\n"
                "* **Patient Support:** Nutrition, diet, and exercise `guidance`, along with a `chatbot` providing answers and guidance through `text-to-speech` and `speech-to-text` capabilities.\n\n"
                "**Data and Research**\n"
                "* **The Breast Cancer Awareness app** is built on a foundation of thorough research and collaboration with medical professionals. We've incorporated insights from reputable studies and partnered with experts in the field to develop the deep learning models. The app's content is curated based on evidence-based information to ensure accuracy and reliability.\n\n"
                "**Contact and App Privacy**",
          ),
          const TextWellFormattedWithBulleted(
            isSelectableText: true,
            data: ///////// change this email //////////
                "* **Contact us** through this email: salahforgraduationproject@gmail.com",
          ),
          BulletedList(
            text: TextWithActionText(
              text: "App Privacy ",
              actionText: "Privacy Policy",
              actionTextStyle: const TextStyle(color: Colors.blue),
              onActionTextTap: () {
                launchUrl(
                  Uri.parse(
                      "https://github.com/salahalshafey/breast-cancer-awareness-privacy/blob/main/privacy-policy.md"),
                  mode: LaunchMode.inAppWebView,
                );
              },
            ),
          ),
          const SizedBox(height: 100),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError) {
                return const Text("");
              }

              final info = snapshot.data!;

              return Column(
                children: [
                  const IconFromAsset(
                    assetIcon: "assets/images/background_cancer_sympol.png",
                    iconHeight: 150,
                  ),
                  Text(
                    info.appName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: MyColors.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Version ${info.version}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: MyColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
