import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';
import '../../../core/util/widgets/image_container.dart';
import '../../account/domain/entities/user_information.dart';
import '../../account/presentation/providers/account.dart';

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
