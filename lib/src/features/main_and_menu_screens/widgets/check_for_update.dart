// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ntp/ntp.dart';

import '../../../core/network/network_info.dart';
import '../../../core/util/builders/custom_alret_dialoge.dart';

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
        daysToUpdate == 0 || daysToUpdate == 1 ? "1 day" : "$daysToUpdate days";

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
    title: "Need Update",
    contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
    content: "App current version isn't supported enymore, You have to update "
        "to the latest version.",
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
        child: const Text("Update"),
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
    titleColor: titleColor,
    title: "Need Update",
    contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
    content: "This version of Breast Cancer Awareness needs "
        "to be **updated in $daysToUpdateString**.\n\n"
        "Update to the latest version?",
    actionsBuilder: (dialogContext) => [
      OutlinedButton(
        onPressed: () {
          Navigator.of(dialogContext).pop();
        },
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(titleColor),
          side: MaterialStatePropertyAll(BorderSide(color: titleColor)),
        ),
        child: const Text("Later"),
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
        child: const Text("Update"),
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
    titleColor: titleColor,
    title: "Update App?",
    contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
    content: "A new version of Breast Cancer Awareness is available! "
        "Version $latestAppVersion is now available-you have $currentAppVersion.\n\n"
        "Would you like to update it now?",
    actionsBuilder: (dialogContext) => [
      OutlinedButton(
        onPressed: () {
          Navigator.of(dialogContext).pop();
        },
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(titleColor),
          side: MaterialStatePropertyAll(BorderSide(color: titleColor!)),
        ),
        child: const Text("Later"),
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
        child: const Text("Update"),
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
