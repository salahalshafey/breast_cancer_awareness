import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/widgets/image_container.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/functions/date_time_and_duration.dart';

import '../providers/account.dart';

import '../widgets/profile/delete_account_button.dart';
import '../widgets/profile/guest_view.dart';
import '../widgets/profile/info_with_icon.dart';

class ProfileScreen extends StatelessWidget {
  static const routName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context, listen: false);

    return DefaultScreen(
      child: RefreshIndicator(
        onRefresh: account.updateAndGetUserInfo,
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

            if (userInfo.id == "guest") {
              return GuestView(userInfo: userInfo, account: account);
            }

            final providerId = FirebaseAuth
                .instance.currentUser!.providerData.first.providerId;

            return ListView(
              padding:
                  const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
              children: [
                Align(
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
                const SizedBox(height: 40),
                InfoWithIcon(
                  icon: ProviderIcon(providerId),
                  info: userInfo.email,
                ),
                const SizedBox(height: 20),
                InfoWithIcon(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                    color: MyColors.primaryColor,
                  ),
                  info: "${userInfo.firstName} ${userInfo.lastName}",
                  tooltip: "full name",
                ),
                const SizedBox(height: 20),
                InfoWithIcon(
                  icon: Icon(
                    userInfo.phoneNumber == null
                        ? Icons.phonelink_erase_rounded
                        : Icons.phone_android,
                    size: 30,
                    color: MyColors.primaryColor,
                  ),
                  info: userInfo.phoneNumber ?? "No phone number provided",
                  tooltip: "phone number",
                ),
                const SizedBox(height: 20),
                InfoWithIcon(
                  icon: const Icon(
                    Icons.work_outline,
                    size: 30,
                    color: MyColors.primaryColor,
                  ),
                  info: userInfo.userType,
                  tooltip: "user type",
                ),
                const SizedBox(height: 20),
                InfoWithIcon(
                  icon: const Icon(
                    Icons.date_range,
                    size: 30,
                    color: MyColors.primaryColor,
                  ),
                  info:
                      "Joined ${wellFormattedDateWithoutDay(userInfo.dateOfSignUp)}",
                  textAlign: TextAlign.center,
                  tooltip: wellFormattedDateTimeLong(
                    userInfo.dateOfSignUp,
                    seperateByLine: true,
                  ),
                ),
                const SizedBox(height: 40),
                Align(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text("    Edit Profile    "),
                    style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size.fromWidth(260)),
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const DeleteAccountButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProviderIcon extends StatelessWidget {
  const ProviderIcon(this.providerId, {super.key});

  final String providerId;

  @override
  Widget build(BuildContext context) {
    return providerId == "google.com"
        ? Image.asset("assets/images/google.png", height: 30)
        : providerId == "facebook.com"
            ? Image.asset("assets/images/facebook.png", height: 30)
            : providerId == "twitter.com"
                ? Image.asset("assets/images/twitter_x.png", height: 30)
                : const Icon(
                    Icons.email_outlined,
                    size: 30,
                    color: MyColors.primaryColor,
                  );
  }
}
