// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../providers/account.dart';

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
          "* You will be asked to confirm your credentials to ensure it is you.",
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
      ], /*,*/
    );
  }

  void deleteTheAccount() async {
    final delete = await _showConfirmDeletionDialog();

    if (delete == null || delete == false) {
      return;
    }

    // if provider is password show dialog to enter password and pop(credentials)
    // then , use the credentials to reauthenticate:
    // await user?.reauthenticateWithCredential(credential);

    try {
      // if provider is social show dialog to confirm to resign in
      // then get credentials by sign in with social
      // await user?.reauthenticateWithCredential(credential);

      _setLoadingState(true);

      final account = Provider.of<Account>(context, listen: false);

      await account.deleteEveryThingToCurrentUser();
      account.signOut(context);

      Navigator.of(context).pop();
    } catch (error) {
      _setLoadingState(false);

      showCustomAlretDialog(
        context: context,
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
