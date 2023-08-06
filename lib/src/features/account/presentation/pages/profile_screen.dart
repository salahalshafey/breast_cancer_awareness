import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/widgets/image_container.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../providers/account.dart';

class ProfileScreen extends StatelessWidget {
  static const routName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      child: RefreshIndicator(
        onRefresh:
            Provider.of<Account>(context, listen: false).updateAndGetUserInfo,
        child: FutureBuilder(
          future: Provider.of<Account>(context).getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // if error or no internet connection
            else if (snapshot.hasError || snapshot.data == null) {
              final topPadding = (MediaQuery.of(context).size.height - 20) / 2;

              return ListView(
                padding: EdgeInsets.only(top: topPadding),
                children: [
                  Text(
                    snapshot.error == null
                        ? "Something went wrong!!"
                        : "${snapshot.error}",
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }

            final userInfo = snapshot.data!;

            return ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 150, horizontal: 40),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ImageContainer(
                    image:
                        userInfo.imageUrl ?? "assets/images/person_avatar.png",
                    imageSource:
                        userInfo.imageUrl == null ? From.asset : From.network,
                    radius: 60,
                    saveNetworkImageToLocalStorage: kIsWeb ? false : true,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromRGBO(191, 76, 136, 1)),
                    showHighlight: true,
                    showLoadingIndicator: true,
                    showImageScreen: userInfo.imageUrl == null ? false : true,
                    imageTitle: wellFormatedString(
                        "${userInfo.firstName} ${userInfo.lastName}"),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    wellFormatedString(
                        "${userInfo.firstName} ${userInfo.lastName}"),
                    style: const TextStyle(
                      color: Color.fromRGBO(193, 27, 107, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userInfo.email,
                    style: const TextStyle(
                      color: MyColors.tetraryColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userInfo.userType,
                    style: const TextStyle(
                      color: MyColors.tetraryColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
