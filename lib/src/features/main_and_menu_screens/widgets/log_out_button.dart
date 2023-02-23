import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';
import '../../account/presentation/providers/account.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: OutlinedButton.icon(
        onPressed: () {
          Provider.of<Account>(context, listen: false).signOut(context);
        },
        label: const Text(
          "Log out",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.logout),
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(MyColors.tetraryColor),
          side: MaterialStatePropertyAll(
              BorderSide(color: MyColors.tetraryColor)),
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
        ),
      ),
    );
  }
}
