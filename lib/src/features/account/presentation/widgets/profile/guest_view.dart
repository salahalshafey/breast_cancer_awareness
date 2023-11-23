import 'package:flutter/material.dart';

import '../../../../../core/util/widgets/image_container.dart';
import '../../../domain/entities/user_information.dart';
import '../../providers/account.dart';

class GuestView extends StatelessWidget {
  const GuestView({
    super.key,
    required this.userInfo,
    required this.account,
  });

  final UserInformation userInfo;
  final Account account;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 40),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ImageContainer(
            image: "assets/images/person_avatar.png",
            imageSource: From.asset,
            radius: 60,
            shape: BoxShape.circle,
            border: Border.all(color: const Color.fromRGBO(191, 76, 136, 1)),
            showHighlight: true,
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "You Are a Guest",
            style: TextStyle(
              color: Color.fromRGBO(193, 27, 107, 1),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 100),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () {
              account.signOut(context);
              Navigator.of(context).pop();
            },
            child: const Text("Sign In"),
          ),
        ),
      ],
    );
  }
}
