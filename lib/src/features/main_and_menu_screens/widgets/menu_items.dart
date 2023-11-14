import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/colors.dart';
import '../../account/presentation/widgets/icon_from_asset.dart';
import '../main_screen_state_provider.dart';

import '../../settings/pages/settings_screen.dart';
import '../about_screen.dart';
import '../../account/presentation/pages/profile_screen.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  void _goToScreen(BuildContext context, Widget screen) {
    // Navigator.of(context).pushNamed(ProfileScreen.routName);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          title: "Home",
          assetIcon: "assets/icons/home_icon.svg",
          iconHeight: 40,
          onTap: () {
            Provider.of<MainScreenState>(context, listen: false).jumpToPage(0);
            ZoomDrawer.of(context)!.close();
          },
        ),
        MenuItem(
          title: "Profile",
          assetIcon: "assets/icons/normal_user_icon.png",
          iconHeight: 40,
          onTap: () => _goToScreen(context, const ProfileScreen()),
        ),
        MenuItem(
          title: "Settings",
          assetIcon: "assets/icons/settings_icon.png",
          iconHeight: 40,
          onTap: () => _goToScreen(context, const SettingsScreen()),
        ),
        MenuItem(
          title: "Share",
          assetIcon: "assets/icons/share_icon.png",
          iconHeight: 40,
          onTap: () {
            Share.share(
              "          \"Breast Cancer Awareness App\"\n\n"
              "Empowering individuals to take charge of their breast health.\n\n"
              "You can download this app from Google Play, by following this link: \n"
              "https://play.google.com/store/apps/details?id=com.salahalshafey.breastcancerawareness",
            );
          },
        ),
        MenuItem(
          title: "About",
          assetIcon: "assets/icons/about_icon.png",
          iconHeight: 40,
          onTap: () => _goToScreen(context, const AboutScreen()),
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
