import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/util/extensions/list_seperator.dart';
import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/widgets/image_container.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/functions/date_time_and_duration.dart';
import '../../../../core/util/builders/go_to_screen_with_slide_transition.dart';

import '../../domain/entities/user_information.dart';
import '../providers/account.dart';

import '../providers/delete_account_state_provider.dart';
import '../widgets/get_user_type_with_localizations.dart';
import 'edit_profile_screen.dart';
import '../widgets/icon_from_asset.dart';
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
      containingBackgroundRightSympol: false,
      child: ChangeNotifierProvider<DeleteAccountState>(
        create: (ctx) => DeleteAccountState(),
        child: RefreshIndicator(
          onRefresh: account.refreshAndGetUserInfo,
          child: FutureBuilder(
            future: Provider.of<Account>(context).getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // if error or no internet connection
              else if (snapshot.hasError || snapshot.data == null) {
                final topPadding =
                    (MediaQuery.of(context).size.height - 20) / 2;

                return ListView(
                  padding: EdgeInsets.only(top: topPadding),
                  children: [
                    Text(
                      snapshot.error == null
                          ? AppLocalizations.of(context)!.somethingWentWrong
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
                    alignment: AlignmentDirectional.centerStart,
                    child: ImageContainer(
                      image: userInfo.imageUrl ??
                          "assets/images/person_avatar.png",
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
                  Align(
                    alignment: AlignmentDirectional.centerStart,
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
                  const SizedBox(),
                  ...[
                    InfoWithIcon(
                      icon: ProviderIcon(providerId),
                      info: userInfo.email,
                      tooltip: providerId == "password"
                          ? AppLocalizations.of(context)!.email
                          : AppLocalizations.of(context)!
                              .emailOfYourProviderAccount(
                              providerName(providerId),
                            ),
                    ),
                    InfoWithIcon(
                      icon: const Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                        color: MyColors.primaryColor,
                      ),
                      info: "${userInfo.firstName} ${userInfo.lastName}",
                      tooltip: AppLocalizations.of(context)!.fullName,
                    ),
                    InfoWithIcon(
                      icon: Icon(
                        userInfo.phoneNumber == null ||
                                userInfo.phoneNumber!.trim().isEmpty
                            ? Icons.phonelink_erase_rounded
                            : Icons.phone_android,
                        size: 30,
                        color: MyColors.primaryColor,
                      ),
                      info: userInfo.phoneNumber == null ||
                              userInfo.phoneNumber!.trim().isEmpty
                          ? AppLocalizations.of(context)!.noPhoneNumberProvided
                          : userInfo.phoneNumber!,
                      tooltip: AppLocalizations.of(context)!.phoneNumber,
                      textDirection: TextDirection.ltr,
                    ),
                    InfoWithIcon(
                      icon: UserTypeIcon(userInfo.userType),
                      info: AppLocalizations.of(context)!.userOf(
                        getuserTypeWithLocalizations(userInfo.userType),
                      ),
                      tooltip: AppLocalizations.of(context)!.userType,
                    ),
                    InfoWithIcon(
                      icon: const Icon(
                        Icons.date_range,
                        size: 30,
                        color: MyColors.primaryColor,
                      ),
                      info: AppLocalizations.of(context)!.joinedIn(
                        wellFormattedDateWithoutDay(
                            userInfo.dateOfSignUp.toLocal()),
                      ),
                      tooltip: wellFormattedDateTimeLong(
                        userInfo.dateOfSignUp.toLocal(),
                        seperateByLine: true,
                      ),
                    ),
                  ]
                      .animate(delay: 300.ms, interval: 100.ms)
                      .fadeIn(duration: 200.ms),
                  const SizedBox(),
                  Align(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        goToScreenWithSlideTransition(
                          context,
                          EditProfileScreen(userInfo),
                          beginOffset: const Offset(0, 0),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: Text(AppLocalizations.of(context)!.editProfile),
                      style: const ButtonStyle(
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(260)),
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      ),
                    ),
                  ),
                  DeleteAccountButton(context),
                ].verticalSeperateBy(const SizedBox(height: 20)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserTypeIcon extends StatelessWidget {
  const UserTypeIcon(this.userType, {super.key});

  final UserTypes userType;

  @override
  Widget build(BuildContext context) {
    return IconFromAsset(
      assetIcon: userType == UserTypes.doctor
          ? "assets/icons/doctor_icon.png"
          : userType == UserTypes.patient
              ? "assets/icons/patient_icon.svg"
              : "assets/icons/normal_user_icon.png",
      iconHeight: 30,
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

String providerName(String providerId) {
  switch (providerId) {
    case "google.com":
      return AppLocalizations.of(context)!.google;
    case "facebook.com":
      return AppLocalizations.of(context)!.facebook;
    case "twitter.com":
      return AppLocalizations.of(context)!.twitter;
    default:
      return AppLocalizations.of(context)!.email;
  }
}
