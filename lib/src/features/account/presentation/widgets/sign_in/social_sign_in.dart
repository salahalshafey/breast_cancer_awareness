// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/error/error_exceptions_with_message.dart';
import '../../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../../../core/util/builders/custom_snack_bar.dart';

import '../../providers/account.dart';

class SocialSignIn extends StatefulWidget {
  const SocialSignIn({super.key});

  @override
  State<SocialSignIn> createState() => _SocialSignInState();
}

class _SocialSignInState extends State<SocialSignIn> {
  bool _isLoading = false;

  void _setLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _signInWithSocial(Function() signIn) async {
    _setLoadingState(true);

    try {
      await signIn();
    } on ErrorForSnackBar catch (error) {
      _setLoadingState(false);

      showCustomSnackBar(
        context: context,
        content: error.toString(),
        durationInSec: 3,
      );
    } catch (error) {
      _setLoadingState(false);

      showCustomAlretDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        content: error.toString(),
        titleColor: Colors.red,
      );
    }
  }

  void _signInWithGoogle() {
    final account = Provider.of<Account>(context, listen: false);

    _signInWithSocial(account.signInWithGoogle);
  }

  void _signInWithFacebook() {
    final account = Provider.of<Account>(context, listen: false);

    _signInWithSocial(account.signInWithFacebook);
  }

  void _signInWithTwitterX() {
    final account = Provider.of<Account>(context, listen: false);

    _signInWithSocial(account.signInWithTwitter);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SizedBox(
            height: 56,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Image.asset("assets/images/facebook.png", height: 40),
                onPressed: _signInWithFacebook,
                tooltip: AppLocalizations.of(context)!
                    .signInUsingProviderAccount(
                        AppLocalizations.of(context)!.facebook),
              ),
              IconButton(
                icon: Image.asset("assets/images/google.png", height: 40),
                onPressed: _signInWithGoogle,
                tooltip: AppLocalizations.of(context)!
                    .signInUsingProviderAccount(
                        AppLocalizations.of(context)!.google),
              ),
              IconButton(
                icon: Image.asset("assets/images/twitter_x.png", height: 40),
                onPressed: _signInWithTwitterX,
                tooltip: AppLocalizations.of(context)!
                    .signInUsingProviderAccount(
                        AppLocalizations.of(context)!.twitter),
              ),
            ],
          );
  }
}
