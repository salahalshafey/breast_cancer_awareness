import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      alignment: AlignmentDirectional.bottomStart,
      child: OutlinedButton.icon(
        onPressed: () async {
          account.signOut(context);
        },
        label: Text(
          account.userId == "guest"
              ? AppLocalizations.of(context)!.signIn
              : AppLocalizations.of(context)!.logout,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: Icon(account.userId == "guest" ? Icons.login : Icons.logout),
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(MyColors.tetraryColor),
          side:
              WidgetStatePropertyAll(BorderSide(color: MyColors.tetraryColor)),
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
        ),
      ),
    );
  }
}
