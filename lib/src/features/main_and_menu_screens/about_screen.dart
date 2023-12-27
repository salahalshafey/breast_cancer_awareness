// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/util/builders/custom_alret_dialog.dart';
import '../../core/util/widgets/bulleted_list.dart';
import '../../core/util/widgets/default_screen.dart';
import '../../core/theme/colors.dart';
import '../../core/util/widgets/text_well_formatted.dart';

import '../../core/util/widgets/text_with_action_text.dart';
import '../account/presentation/widgets/icon_from_asset.dart';
import 'widgets/check_for_update.dart';

class AboutScreen extends StatelessWidget {
  static const routName = '/profile';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      appBarActions: const [CheckForUpdatesButton()],
      child: ListView(
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          top: 100,
          bottom: 50,
        ),
        children: [
          Text(
            AppLocalizations.of(context)!.appOverview,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: MyColors.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...[
            TextWellFormattedWithBulleted(
              data: AppLocalizations.of(context)!.appOverviewdetailed,
            ),
            const SizedBox(height: 30),
            BulletedList(text: Text(AppLocalizations.of(context)!.contactUs)),
            const BulletedList(
              bullet: SizedBox(width: 5),
              text: TextWellFormattedWitouthBulleted(
                data: "salahforgraduationproject@gmail.com",
                isSelectableText: true,
                textDirection: null,
              ),
            ),
            const SizedBox(height: 30),
            BulletedList(
              text: TextWithActionText(
                text: AppLocalizations.of(context)!.app,
                actionText: AppLocalizations.of(context)!.privacyPolicy,
                actionTextStyle: const TextStyle(color: Colors.blue),
                onActionTextTap: () {
                  launchUrl(
                    Uri.parse(
                        "https://breastcancerawareness-privacypolicy.tiiny.site/"),
                    mode: LaunchMode.inAppWebView,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            BulletedList(
              //  bullet: const SizedBox(width: 5),
              text: TextWithActionText(
                text: "", //AppLocalizations.of(context)!.and,
                actionText: AppLocalizations.of(context)!.termsOfService,
                actionTextStyle: const TextStyle(color: Colors.blue),
                onActionTextTap: () {
                  launchUrl(
                    Uri.parse(
                        "https://breastcancerawareness-termsofservice.tiiny.site/"),
                    mode: LaunchMode.inAppWebView,
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
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
          ].animate(delay: 300.ms).fadeIn(duration: 1000.ms),
        ],
      ),
    );
  }
}

class CheckForUpdatesButton extends StatelessWidget {
  const CheckForUpdatesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)!.checkForUpdates,
      icon: const Icon(Icons.update),
      onPressed: () async {
        final updatesFound = await checkForUpdateWithDialog(context);

        if (updatesFound == null) {
          showCustomAlretDialog(
            context: context,
            title: AppLocalizations.of(context)!.error,
            content: AppLocalizations.of(context)!
                .errorHappendWhileCheckingForUpdates,
            titleColor: Colors.red,
          );
          return;
        }

        if (!updatesFound) {
          showCustomAlretDialog(
            context: context,
            title: AppLocalizations.of(context)!.noUpdates,
            content: AppLocalizations.of(context)!.youHaveTheLatestVersion,
            titleColor: Theme.of(context).appBarTheme.foregroundColor,
          );
        }
      },
    );
  }
}
