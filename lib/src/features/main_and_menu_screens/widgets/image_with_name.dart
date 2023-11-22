import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';
import '../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../core/util/widgets/image_container.dart';

import '../../account/domain/entities/user_information.dart';
import '../../account/presentation/providers/account.dart';

import '../../account/presentation/pages/profile_screen.dart';

class ImageWithName extends StatelessWidget {
  const ImageWithName({super.key});

  void _goToProfileScreen(BuildContext context) {
    // Navigator.of(context).pushNamed(ProfileScreen.routName);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ProfileScreen(),
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
    final account = Provider.of<Account>(context);

    return FutureBuilder<UserInformation?>(
      key: UniqueKey(),
      future: account.getUserInfo(),
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
                  saveNetworkImageToLocalStorage: kIsWeb ? false : true,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color.fromRGBO(191, 76, 136, 1)),
                  showHighlight: true,
                  showLoadingIndicator: true,
                  onTap: () => _goToProfileScreen(context),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                // width: 200,
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: ListTile(
                  onTap: () => _goToProfileScreen(context),
                  title: Text(
                    userInfo.id == "guest"
                        ? "Guest"
                        : wellFormatedString(
                            "${userInfo.firstName} ${userInfo.lastName}",
                          ),
                    style: const TextStyle(
                      fontSize: 18,
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
