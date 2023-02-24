import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../core/util/builders/custom_snack_bar.dart';
import '../../../../core/util/functions/general_functions.dart';

import '../providers/for_doctor_screen_state_provider.dart';

class ReadLinkByQRCode extends StatefulWidget {
  const ReadLinkByQRCode({super.key});

  @override
  State<ReadLinkByQRCode> createState() => _ReadLinkByQRCodeState();
}

class _ReadLinkByQRCodeState extends State<ReadLinkByQRCode> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context, listen: false);

    return TextButton(
      onPressed: () async {
        try {
          final String imagelink = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', 'Cancel', true, ScanMode.QR);
          if (!mounted) return;

          if (imagelink == "-1") {
            showCustomSnackBar(
              context: context,
              content: "you didn't read QR Code",
            );
            return;
          }

          final error = await validateImageLink(imagelink);
          if (!mounted) return;

          if (error != null) {
            showCustomAlretDialog(
              context: context,
              title: "Error",
              content: error,
              titleColor: Colors.red,
            );
            return;
          }

          provider.setNetworkImage(imagelink);
        } on PlatformException {
          showCustomAlretDialog(
            context: context,
            title: "Error",
            content: "Error happened while trying to open QR Code Scanner",
            titleColor: Colors.red,
          );
        }
      },
      child: Text(
        "Get Image Link By Reading QR Code",
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
