// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ntp/ntp.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/network/network_info.dart';
import '../../../core/util/builders/custom_alret_dialog.dart';
import '../../../core/util/functions/nouns_in_diff_languages.dart';

/// ### This is useful for button `Check for update`.
///
/// * If return `null` this means that error happend while checking for updates.
///
/// * If return `true` this means there is an update and dialog will popup.
///
/// * If return `false` this means there is no updates and no dialog.

Future<bool?> checkForUpdateWithDialog(BuildContext context) async {
  final updatesInfo = await checkForAnyUpdates();
  if (updatesInfo == null) {
    return null;
  }

  final currentAppVersion = updatesInfo["current_version"] as String;
  final latestAppVersion = updatesInfo["latest_version"] as String;
  final versionToForceUpdateIfBelow =
      updatesInfo["force_update_versions_below"] as String;

  final forceUpdateAfter =
      (updatesInfo["force_update_after"] as Timestamp).toDate();
  final currentDateTime = updatesInfo["current_date_time"] as DateTime;

  if (currentAppVersion < versionToForceUpdateIfBelow &&
      currentDateTime.isAfter(forceUpdateAfter)) {
    forcUpdateDialog(context);

    return true;
  }

  if (currentAppVersion < versionToForceUpdateIfBelow) {
    final daysToUpdate = forceUpdateAfter.difference(currentDateTime).inDays;
    final daysToUpdateString =
        dayWithLocalization(daysToUpdate == 0 ? 1 : daysToUpdate);

    forceUpdateAfterDaysDialog(context, daysToUpdateString);

    return true;
  }

  if (currentAppVersion < latestAppVersion) {
    selectiveUpdateDialog(context, latestAppVersion, currentAppVersion);

    return true;
  }

  return false;
}

//////////////////////  Dialoges for updates checking //////////////////////////
///////////////////////
////////////

void forcUpdateDialog(BuildContext context) {
  showCustomAlretDialog(
    context: context,
    constraints: const BoxConstraints(maxWidth: 500),
    canPopScope: false,
    barrierDismissible: false,
    title: AppLocalizations.of(context)!.needUpdate,
    contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
    content:
        AppLocalizations.of(context)!.thisVersionOfTheAppNotSupportedAnymore,
    actionsBuilder: (dialogContext) => [
      ElevatedButton(
        onPressed: () {
          launchUrl(
            Uri.parse(
                "https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness"),
            mode: LaunchMode.externalApplication,
          );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade900)),
        child: Text(AppLocalizations.of(context)!.update),
      ),
    ],
  );
}

void forceUpdateAfterDaysDialog(
    BuildContext context, String daysToUpdateString) {
  const titleColor = Colors.red;

  showCustomAlretDialog(
    context: context,
    constraints: const BoxConstraints(maxWidth: 500),
    barrierDismissible: false,
    titleColor: titleColor,
    title: AppLocalizations.of(context)!.needUpdate,
    contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
    content: AppLocalizations.of(context)!
        .thisVersionOfTheAppNotSupportedAfterDays(daysToUpdateString),
    actionsBuilder: (dialogContext) => [
      OutlinedButton(
        onPressed: () {
          Navigator.of(dialogContext).pop();
        },
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(titleColor),
          side: MaterialStatePropertyAll(BorderSide(color: titleColor)),
        ),
        child: Text(AppLocalizations.of(context)!.later),
      ),
      ElevatedButton(
        onPressed: () {
          launchUrl(
            Uri.parse(
                "https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness"),
            mode: LaunchMode.externalApplication,
          );
        },
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(titleColor)),
        child: Text(AppLocalizations.of(context)!.update),
      ),
    ],
  );
}

void selectiveUpdateDialog(
    BuildContext context, String latestAppVersion, String currentAppVersion) {
  final titleColor = Theme.of(context).appBarTheme.foregroundColor;

  showCustomAlretDialog(
    context: context,
    constraints: const BoxConstraints(maxWidth: 500),
    barrierDismissible: false,
    titleColor: titleColor,
    title: AppLocalizations.of(context)!.updateApp,
    contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
    content: AppLocalizations.of(context)!
        .newVersionOfTheAppIsAvailable(latestAppVersion, currentAppVersion),
    actionsBuilder: (dialogContext) => [
      OutlinedButton(
        onPressed: () {
          Navigator.of(dialogContext).pop();
        },
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(titleColor),
          side: MaterialStatePropertyAll(BorderSide(color: titleColor!)),
        ),
        child: Text(AppLocalizations.of(context)!.later),
      ),
      ElevatedButton(
        onPressed: () {
          launchUrl(
            Uri.parse(
                "https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness"),
            mode: LaunchMode.externalApplication,
          );
        },
        style:
            ButtonStyle(backgroundColor: MaterialStatePropertyAll(titleColor)),
        child: Text(AppLocalizations.of(context)!.update),
      ),
    ],
  );
}

Future<Map<String, dynamic>?> checkForAnyUpdates() async {
  if (await NetworkInfoImpl().isNotConnected) {
    return null;
  }

  try {
    final document = await FirebaseFirestore.instance
        .collection('app_update')
        .doc('check_for_updates')
        .get();

    if (document.data() == null) {
      return null;
    }

    final currentAppVersion = (await PackageInfo.fromPlatform()).version;
    final currentDateTime = await getCurrentNetworkTime();

    final updatesInfo = document.data()!
      ..addAll({
        "current_version": currentAppVersion,
        "current_date_time": currentDateTime,
      });

    return updatesInfo;
  } catch (error) {
    return null;
  }
}

Future<DateTime> getCurrentNetworkTime() async {
  try {
    return await NTP.now();
  } catch (error) {
    return DateTime.now();
  }
}

extension IsVersionLessThan on String {
  /// Only used for app version comparison.

  bool operator <(String other) {
    final thisVersionNums =
        split(".").map((versionNum) => int.parse(versionNum));
    final otherVersionNums =
        other.split(".").map((versionNum) => int.parse(versionNum));

    final numOfIteration = min(thisVersionNums.length, otherVersionNums.length);

    for (int i = 0; i < numOfIteration; i++) {
      if (thisVersionNums.elementAt(i) < otherVersionNums.elementAt(i)) {
        return true;
      }
    }

    return false;
  }
}
