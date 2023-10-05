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
    final account = Provider.of<Account>(context, listen: false);

    return Align(
      alignment: Alignment.bottomLeft,
      child: OutlinedButton.icon(
        onPressed: () async {
          account.signOut(context);
        },
        label: Text(
          account.userId == "guest" ? "Sign In" : "Log out",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: Icon(account.userId == "guest" ? Icons.login : Icons.logout),
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
