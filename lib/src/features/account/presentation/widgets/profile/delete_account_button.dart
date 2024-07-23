// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/builders/custom_alret_dialog.dart';

import '../../../../breast_cancer_for_normal/presentation/providers/notes.dart';
import '../../providers/account.dart';
import '../../providers/delete_account_state_provider.dart';

import 'password_text_field_to_delete_account.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton(
    this.profileScreenContext, {
    super.key,
  });

  final BuildContext profileScreenContext;

  Future<bool?> _showConfirmDeletionDialog() {
    return showCustomAlretDialog<bool>(
      context: profileScreenContext,
      constraints: const BoxConstraints(maxWidth: 500),
      title: AppLocalizations.of(profileScreenContext)!.dangerousArea,
      content: AppLocalizations.of(profileScreenContext)!
          .areYouSureOfDeletingYourAccount,
      actionsPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      actionsBuilder: (dialogContext) => [
        ElevatedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(true);
          },
          style: ButtonStyle(
            // padding: const WidgetStatePropertyAll(
            //   EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            //  ),
            backgroundColor: WidgetStatePropertyAll(Colors.red.shade900),
          ),
          child: Text(AppLocalizations.of(profileScreenContext)!.delete),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(false);
          },
          style: ButtonStyle(
            //  padding: const WidgetStatePropertyAll(
            //    EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            //   ),
            foregroundColor: WidgetStatePropertyAll(Colors.red.shade900),
            side:
                WidgetStatePropertyAll(BorderSide(color: Colors.red.shade900)),
          ),
          child: Text(AppLocalizations.of(profileScreenContext)!.cancel),
        ),
      ],
    );
  }

  Future<bool?> _showConfirmPasswordDialog() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final passwordConfirmed = await showCustomAlretDialog<bool>(
      context: profileScreenContext,
      title: AppLocalizations.of(profileScreenContext)!.deleteAccount,
      content: AppLocalizations.of(profileScreenContext)!
          .pleaseEnterYourPasswordToConfirm,
      contentWidget: const PasswordTextFieldToDeleteAccount(),
      actionsBuilder: (dialogContext) => [],
      actionsPadding: const EdgeInsets.all(0),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);

    return passwordConfirmed;
  }

  void deleteTheAccount() async {
    final delete = await _showConfirmDeletionDialog();

    if (delete == null || delete == false) {
      return;
    }

    final providerId =
        FirebaseAuth.instance.currentUser!.providerData.first.providerId;

    if (providerId == "password") {
      final passwordConfirmed = await _showConfirmPasswordDialog();

      if (passwordConfirmed == null || passwordConfirmed == false) {
        return;
      }
    }

    final provider =
        Provider.of<DeleteAccountState>(profileScreenContext, listen: false);

    try {
      provider.setLoadingState(true);

      final account = Provider.of<Account>(profileScreenContext, listen: false);
      final notes = Provider.of<Notes>(profileScreenContext, listen: false);
      final userId = account.userId;

      // if providerId is social
      if (providerId != "password") {
        await account.reauthenticateWithSocialCredential(providerId);
      }

      await account.deleteEveryThingToCurrentUser();
      notes.deleteAllNotes(userId);

      account.signOut(profileScreenContext);
      Navigator.of(profileScreenContext).pop();
    } catch (error) {
      provider.setLoadingState(false);

      showCustomAlretDialog(
        context: profileScreenContext,
        constraints: const BoxConstraints(maxWidth: 400),
        title: AppLocalizations.of(profileScreenContext)!.error,
        content: error.toString(),
        titleColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeleteAccountState>(profileScreenContext);

    return Align(
      child: ElevatedButton.icon(
        onPressed: provider.isLoading ? null : deleteTheAccount,
        icon: const Icon(Icons.delete),
        label: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              AppLocalizations.of(profileScreenContext)!.deleteAccount,
              textAlign: TextAlign.center,
              style: provider.isLoading
                  ? const TextStyle(color: Colors.transparent)
                  : null,
            ),
            if (provider.isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3.0,
                ),
              )
          ],
        ),
        style: ButtonStyle(
          // fixedSize: const WidgetStatePropertyAll(Size.fromWidth(270)),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 8, horizontal: 25)),
          backgroundColor: WidgetStatePropertyAll(Colors.red.shade900),
        ),
      ),
    );
  }
}
