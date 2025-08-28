// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../core/util/builders/custom_alret_dialog.dart';

import '../../providers/account.dart';

import '../dont_or_already_have_accout.dart';

class SignInAsGuestButton extends StatefulWidget {
  const SignInAsGuestButton({super.key});

  @override
  State<SignInAsGuestButton> createState() => _SignInAsGuestButtonState();
}

class _SignInAsGuestButtonState extends State<SignInAsGuestButton> {
  bool _isLoading = false;

  void _isLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void signInAsGuest() async {
    _isLoadingState(true);

    try {
      await Provider.of<Account>(context, listen: false).signInAnonymously();
    } catch (error) {
      _isLoadingState(false);

      showCustomAlretDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        titleColor: Colors.red,
        content: error.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: _isLoading ? 10 : 22),
      child: _isLoading
          ? const CircularProgressIndicator()
          : DontOrAlreadyHaveAccount(
              text: AppLocalizations.of(context)!.signUpLater,
              actionText: AppLocalizations.of(context)!.continueAsGuest,
              onTap: signInAsGuest,
            ),
    );
  }
}
