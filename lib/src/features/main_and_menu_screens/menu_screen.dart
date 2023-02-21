import 'package:breast_cancer_awareness/src/core/theme/colors.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/image_container.dart';
import 'package:breast_cancer_awareness/src/features/account/domain/entities/user_information.dart';
import 'package:breast_cancer_awareness/src/features/account/presentation/widgets/icon_from_asset.dart';
import 'package:breast_cancer_awareness/src/features/main_and_menu_screens/main_screen_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../account/presentation/providers/account.dart';
import 'main_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            bottom: -30,
            child: IconFromAsset(
              assetIcon: "assets/images/background_cancer_sympol.png",
              iconHeight: 150,
              opacity: 0.62,
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            children: [
              const SizedBox(height: 50),
              const ImageWithName(),
              const SizedBox(height: 30),
              const MenuItems(),
              const SizedBox(height: 120),
              Align(
                alignment: Alignment.bottomLeft,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    Provider.of<MainScreenState>(context, listen: false)
                        .jumpToPage(0);
                    await Provider.of<Account>(context, listen: false)
                        .signOut();
                  },
                  label: const Text(
                    "Log out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(Icons.logout),
                  style: const ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll(MyColors.tetraryColor),
                      side: MaterialStatePropertyAll(
                          BorderSide(color: MyColors.tetraryColor))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ImageWithName extends StatelessWidget {
  const ImageWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInformation?>(
      future: Provider.of<Account>(context).getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(snapshot.error == null
                ? "Something went wrong!!"
                : "${snapshot.error}"),
          );
        }

        final userInfo = snapshot.data!;

        return Align(
          child: Row(
            children: [
              Opacity(
                opacity:
                    Theme.of(context).brightness == Brightness.dark ? 0.7 : 1,
                child: ImageContainer(
                  image: userInfo.imageUrl ?? "assets/images/person_avatar.png",
                  imageSource:
                      userInfo.imageUrl == null ? From.asset : From.network,
                  radius: 50,
                  saveNetworkImageToLocalStorage: true,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color.fromRGBO(191, 76, 136, 1)),
                  showHighlight: true,
                  showLoadingIndicator: true,
                  onTap: () {},
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                // width: 200,
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    "${userInfo.firstName} ${userInfo.lastName}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: MyColors.tetraryColor,
                    ),
                  ),
                  subtitle: Text(
                    userInfo.email,
                    style: const TextStyle(
                      fontSize: 10,
                      color: MyColors.tetraryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
