import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/functions/general_functions.dart';

import '../pages/qr_code_reader_screen.dart';
import '../providers/for_doctor_screen_state_provider.dart';

class ReadLinkByQRCode extends StatelessWidget {
  const ReadLinkByQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context, listen: false);

    return TextButton(
      onPressed: () {
        Navigator.of(context).push<String?>(MaterialPageRoute(
          builder: (ctx) {
            return const QRCodeReaderScreen();
          },
        )).then((imagelink) {
          if (imagelink == null) {
            /*showCustomSnackBar(
              context: context,
              content: "you didn't read QR Code",
            );*/
          } else {
            validateImageLink(imagelink).then((error) {
              if (error != null) {
                /*showCustomAlretDialog(
                  context: context,
                  title: "Error",
                  content: error,
                  titleColor: Colors.red,
                );*/
              } else {
                provider.setNetworkImage(imagelink);
              }
            });
          }
        });

        /* final String? imagelink =
            await Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return QRCodeReaderScreen();
          },
        ));

        if (imagelink == null) {
          showCustomSnackBar(
            context: context,
            content: "you didn't read QR Code",
          );
          return;
        }

        final error = await validateImageLink(imagelink);
        if (error != null) {
          showCustomAlretDialog(
            context: context,
            title: "Error",
            content: error,
            titleColor: Colors.red,
          );
          return;
        }

        provider.setNetworkImage(imagelink);*/
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
