// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../../core/util/builders/custom_alret_dialoge.dart';

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
    final provider =
        Provider.of<ImageAndUserTypeProvider>(context, listen: false);

    final account = Provider.of<Account>(context, listen: false);
    try {
      _continueButtonLoadingState(true);
      await account.sendUserImageAndType(
          provider.currentImage, provider.userType);

      await _goToMainScreen();
    } catch (error) {
      _continueButtonLoadingState(false);

      setState(() {
        _isSkipForNowButtonShowen = true;
      });

      showCustomAlretDialog(
        context: context,
        title: 'ERROR',
        titleColor: Colors.red,
        content: '$error',
      );
    }
  }

  Future<void> _goToMainScreen() async {
    _skipButtonLoadingState(true);
    final elapsedTime =
        DateTime.now().difference(_dateTimeFromStartingThePage).inSeconds.abs();
    if (elapsedTime < 15) {
      await Future.delayed(Duration(seconds: 15 - elapsedTime));
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const LandingPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _isSkipForNowButtonShowen
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        if (_isSkipForNowButtonShowen)
          _isSkipButtonLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: _goToMainScreen,
                  child: const Text(
                    "Skip For Now",
                  ),
                ),
        _isContinueButtonLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => _sendUserImageAndType(),
                child: const Text(
                  "Continue",
                ),
              ),
      ],
    );
  }
}
