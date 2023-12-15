// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    } catch (error) {
      _setLoadingState(false);

      error.toString().contains("was selected!!!")
          ? showCustomSnackBar(
              context: context,
              content: error.toString(),
              durationInSec: 3,
            )
          : showCustomAlretDialog(
              context: context,
              title: "Error",
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
              ),
              IconButton(
                icon: Image.asset("assets/images/google.png", height: 40),
                onPressed: _signInWithGoogle,
              ),
              IconButton(
                icon: Image.asset("assets/images/twitter_x.png", height: 40),
                onPressed: _signInWithTwitterX,
              ),
            ],
          );
  }
}
