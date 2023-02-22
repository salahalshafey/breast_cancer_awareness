import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/colors.dart';
import '../../account/presentation/widgets/icon_from_asset.dart';
import '../main_screen_state_provider.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

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
          onTap: () {},
        ),
        MenuItem(
          title: "Settings",
          assetIcon: "assets/icons/settings_icon.png",
          iconHeight: 40,
          onTap: () {},
        ),
        MenuItem(
          title: "Share",
          assetIcon: "assets/icons/share_icon.png",
          iconHeight: 40,
          onTap: () {
            Share.share(
              "          \"Breast Cancer Awareness App\"\n"
              "\n"
              "This App is a Graduation Project for the team: \n"
              " 1. Salah Alshafey.\n"
              " 2.Yasser Nabil.\n"
              " 3. Mahmoud Elmasry.\n"
              " 4.Mohmed Shawky.\n"
              " 5. Mostafa Tareq.\n"
              " 6.Abelrahman Mahmoud.\n",
            );
          },
        ),
        MenuItem(
          title: "About",
          assetIcon: "assets/icons/about_icon.png",
          iconHeight: 40,
          onTap: () {},
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
