import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../core/util/builders/go_to_screen_with_slide_transition.dart';

import '../../account/presentation/widgets/icon_from_asset.dart';
import '../main_screen_state_provider.dart';

import '../../settings/pages/settings_screen.dart';
import '../about_screen.dart';
import '../../account/presentation/pages/profile_screen.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          title: AppLocalizations.of(context)!.home,
          assetIcon: "assets/icons/home_icon.svg",
          iconHeight: 40,
          onTap: () {
            Provider.of<MainScreenState>(context, listen: false).jumpToPage(0);
            ZoomDrawer.of(context)!.close();
          },
        ),
        MenuItem(
          title: AppLocalizations.of(context)!.profile,
          assetIcon: "assets/icons/normal_user_icon.png",
          iconHeight: 40,
          onTap: () =>
              goToScreenWithSlideTransition(context, const ProfileScreen()),
        ),
        MenuItem(
          title: AppLocalizations.of(context)!.settings,
          assetIcon: "assets/icons/settings_icon.png",
          iconHeight: 40,
          onTap: () =>
              goToScreenWithSlideTransition(context, const SettingsScreen()),
        ),
        MenuItem(
          title: AppLocalizations.of(context)!.shareTheApp,
          assetIcon: "assets/icons/share_icon.png",
          iconHeight: 40,
          onTap: () {
            Share.share(AppLocalizations.of(context)!.shareTheAppText);
          },
        ),
        MenuItem(
          title: AppLocalizations.of(context)!.about,
          assetIcon: "assets/icons/about_icon.png",
          iconHeight: 40,
          onTap: () =>
              goToScreenWithSlideTransition(context, const AboutScreen()),
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    required this.assetIcon,
    required this.iconHeight,
    this.onTap,
  });

  final String title;
  final String assetIcon;
  final double iconHeight;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          const SizedBox(width: 10),
          IconFromAsset(
            assetIcon: assetIcon,
            iconHeight: iconHeight,
            opacity: Theme.of(context).brightness == Brightness.dark ? 0.7 : 1,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.tetraryColor,
            ),
          )
        ],
      ),
    );
  }
}
