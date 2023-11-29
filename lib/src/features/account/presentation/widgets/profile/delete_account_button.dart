// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../providers/account.dart';
import 'password_text_field_to_delete_account.dart';

class DeleteAccountButton extends StatefulWidget {
  const DeleteAccountButton({
    super.key,
  });

  @override
  State<DeleteAccountButton> createState() => _DeleteAccountButtonState();
}

class _DeleteAccountButtonState extends State<DeleteAccountButton> {
  bool _isLoading = false;

  void _setLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  Future<bool?> _showConfirmDeletionDialog() {
    return showCustomAlretDialog<bool>(
      context: context,
      maxWidth: 500,
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
      context: context,
      title: "Delete Account",
      content: "Please enter your password to confirm deleting your account.",
      contentWidget: const PasswordTextFieldToDeleteAccount(),
      actionsBuilder: (dialogContext) => [const SizedBox()],
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

    try {
      _setLoadingState(true);

      final account = Provider.of<Account>(context, listen: false);

      // if providerId is social
      if (providerId != "password") {
        await account.reauthenticateWithSocialCredential(providerId);
      }

      await account.deleteEveryThingToCurrentUser();
      account.signOut(context);

      Navigator.of(context).pop();
    } catch (error) {
      _setLoadingState(false);

      showCustomAlretDialog(
        context: context,
        maxWidth: 400,
        title: "Error",
        content: error.toString(),
        titleColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : deleteTheAccount,
        icon: const Icon(Icons.delete),
        label: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              "Delete Account",
              style: _isLoading
                  ? const TextStyle(color: Colors.transparent)
                  : null,
            ),
            if (_isLoading)
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
