import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/network/network_info.dart';
import '../../../core/util/builders/custom_alret_dialoge.dart';

import '../main_screen_state_provider.dart';

void checkForUpdate(BuildContext context) async {
  final provider = Provider.of<MainScreenState>(context, listen: false);

  if (provider.appCheckedForUpdate) {
    return;
  }

  checkForAnyUpdates().then((updatesInfo) {
    if (updatesInfo == null) {
      return;
    }

    provider.setAsAlreadyCheckedForUpdate();

    final currentAppVersion = updatesInfo["current_version"] as String;
    final latestAppVersion = updatesInfo["latest_version"] as String;
    final forceUpdate = updatesInfo["force_update"] as bool;

    if (currentAppVersion < latestAppVersion && forceUpdate) {
      showCustomAlretDialog(
        context: context,
        constraints: const BoxConstraints(maxWidth: 500),
        canPopScope: false,
        barrierDismissible: false,
        title: "Need Update",
        content:
            "App current version isn't supported enymore, You have to update "
            "to the latest version.",
        actionsBuilder: (dialogeContext) => [
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
    } else if (currentAppVersion < latestAppVersion) {
      final titleColor = Theme.of(context).appBarTheme.foregroundColor;

      showCustomAlretDialog(
        context: context,
        constraints: const BoxConstraints(maxWidth: 500),
        titleColor: titleColor,
        title: "Update App?",
        content: "A new version of Breast Cancer Awareness is available! "
            "Version $latestAppVersion is now available-you have $currentAppVersion.\n\n"
            "Would you like to update it now?",
        actionsBuilder: (dialogeContext) => [
          OutlinedButton(
            onPressed: () {
              Navigator.of(dialogeContext).pop();
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
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(titleColor)),
            child: const Text("Update"),
          ),
        ],
      );
    }
  });
}

//////////// used above /////////////////////////////
////////////////

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

    final updatesInfo = document.data()!
      ..addAll({"current_version": currentAppVersion});

    return updatesInfo;
  } catch (error) {
    return null;
  }
}

extension on String {
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
