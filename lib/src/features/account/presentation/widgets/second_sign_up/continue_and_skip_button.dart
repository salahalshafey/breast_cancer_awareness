// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../app.dart';
import '../../../../../core/util/builders/custom_alret_dialog.dart';

import '../../../data/datasources/account_remote_authentication.dart';
import '../../providers/account.dart';
import '../../providers/image_and_user_type_provider.dart';

class ContinueAndskipButton extends StatefulWidget {
  const ContinueAndskipButton({super.key});

  @override
  State<ContinueAndskipButton> createState() => _ContinueAndskipButtonState();
}

class _ContinueAndskipButtonState extends State<ContinueAndskipButton> {
  bool _isContinueButtonLoading = false;
  bool _isSkipButtonLoading = false;
  bool _isSkipForNowButtonShowen = false;

  late DateTime _dateTimeFromStartingThePage;

  @override
  void initState() {
    _dateTimeFromStartingThePage = DateTime.now();
    super.initState();
  }

  void _continueButtonLoadingState(bool state) {
    setState(() {
      _isContinueButtonLoading = state;
    });
  }

  void _skipButtonLoadingState(bool state) {
    setState(() {
      _isSkipButtonLoading = state;
    });
  }

  void _sendUserImageAndType() async {
    try {
      _continueButtonLoadingState(true);
      await _sendUpdate();

      await _goToMainScreen();
    } catch (error) {
      _continueButtonLoadingState(false);

      setState(() {
        _isSkipForNowButtonShowen = true;
      });

      showCustomAlretDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        titleColor: Colors.red,
        content: '$error',
      );
    }
  }

  Future<void> _sendUpdate() async {
    final provider =
        Provider.of<ImageAndUserTypeProvider>(context, listen: false);
    final account = Provider.of<Account>(context, listen: false);
    final providerData = FirebaseAuth.instance.currentUser!.providerData;

    if (providerData.isEmpty || providerData.first.providerId == "password") {
      await account.sendUserImageAndType(
          provider.currentImage, provider.userType);

      return;
    }

    var userAuthInfo =
        AccountFirebaseAuthenticationImpl().getCurrentUserAuthInfo();
    userAuthInfo = userAuthInfo.copyWith(userType: provider.userType);

    await account.addOrUpdateUserData(userAuthInfo, provider.currentImage);
  }

  Future<void> _goToMainScreen() async {
    _skipButtonLoadingState(true);
    final elapsedTime =
        DateTime.now().difference(_dateTimeFromStartingThePage).inSeconds.abs();
    if (elapsedTime < 15) {
      await Future.delayed(Duration(seconds: 15 - elapsedTime));
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const LandingPageWithCheckForUpdate();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _isSkipForNowButtonShowen
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (_isSkipForNowButtonShowen)
          _isSkipButtonLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: _goToMainScreen,
                  child: Text(
                    AppLocalizations.of(context)!.skipForNow,
                  ),
                ),
        _isContinueButtonLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => _sendUserImageAndType(),
                child: Text(
                  AppLocalizations.of(context)!.continueToMainScreen,
                ),
              ),
      ],
    );
  }
}
