// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../../core/util/builders/custom_alret_dialoge.dart';

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
      title: "Dangerous area",
      content: "Are you sure of **Deleting your account**? All the data "
          "and information will be deleted. That can't be undone.",
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
          ),
          child: const Text("Delete"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
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

  void deleteTheAccount() async {
    final delete = await _showConfirmDeletionDialog();

    if (delete == null || delete == false) {
      return;
    }

    try {
      _setLoadingState(true);

      await Future.delayed(const Duration(seconds: 2), () {
        throw ErrorDescription("no waaaaaaaaaaaay");
      }); /////  handle deletion
      /////  sign out
      /////  Navigator.of(context).pop();
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
