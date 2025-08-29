// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../../core/util/builders/custom_snack_bar.dart';
import '../../../../core/util/functions/general_functions.dart';

import '../providers/for_doctor_screen_state_provider.dart';
import 'mobile_scanner_widget.dart';

class ReadLinkByQRCode extends StatefulWidget {
  const ReadLinkByQRCode({super.key});

  @override
  State<ReadLinkByQRCode> createState() => _ReadLinkByQRCodeState();
}

class _ReadLinkByQRCodeState extends State<ReadLinkByQRCode> {
  bool _isLoading = false;
  void _setLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _readQRCode() async {
    final forDoctorScreenState =
        Provider.of<ForDoctorScreenState>(context, listen: false);
    try {
      final imagelink = await scanQrAndGetText(context);
      if (!mounted) return;

      if (imagelink == null) {
        showCustomSnackBar(
          context: context,
          content: AppLocalizations.of(context)!.youDidntReadQrCode,
        );
        return;
      }

      _setLoadingState(true);
      final error = await validateImageLink(imagelink);
      if (!mounted) return;
      _setLoadingState(false);

      if (error != null) {
        showCustomAlretDialog(
          context: context,
          title: AppLocalizations.of(context)!.error,
          content: error,
          titleColor: Colors.red,
        );
        return;
      }

      forDoctorScreenState.setNetworkImage(imagelink);
    } on PlatformException {
      showCustomAlretDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!
            .errorHappenedWhileTryingToOpenQrCodeScanner,
        titleColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: CircularProgressIndicator(),
            ),
          )
        : TextButton(
            onPressed: _readQRCode,
            child: Text(
              AppLocalizations.of(context)!.getImageLinkByReadingQrCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
            //style: ButtonStyle(textStyle: ),
          );
  }
}
