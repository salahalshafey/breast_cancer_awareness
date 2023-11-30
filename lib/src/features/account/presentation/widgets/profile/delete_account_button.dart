// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/util/builders/custom_alret_dialoge.dart';

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
      title: "Dangerous area",
      content: "* Are you sure of **Deleting your account?** "
          "All the data and information will be deleted. **That can't be undone.**\n"
          "* You may be asked to **confirm** your credentials to ensure it is you.",
      actionsBuilder: (dialogContext) => [
        ElevatedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
          ),
          child: const Text("Delete"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(false);
          },
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.red.shade900),
            side: MaterialStatePropertyAll(
                BorderSide(color: Colors.red.shade900)),
          ),
          child: const Text("Cancel"),
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
      title: "Delete Account",
      content: "Please enter your password to confirm deleting your account.",
      contentWidget: const PasswordTextFieldToDeleteAccount(),
      actionsBuilder: (dialogContext) => [],
      actionsPaddingAll: 0,
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
        title: "Error",
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
              "Delete Account",
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
          fixedSize: const MaterialStatePropertyAll(Size.fromWidth(270)),
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
        ),
      ),
    );
  }
}
