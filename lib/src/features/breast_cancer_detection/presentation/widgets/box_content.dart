import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/for_doctor_screen_state_provider.dart';

import 'link_form.dart';
import 'read_link_by_qr_code.dart';

class BoxContent extends StatelessWidget {
  const BoxContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          PickImage(),
          Spacer(flex: 2),
          OrDivider(),
          Spacer(flex: 1),
          ReadLinkByQRCode(),
          LinkForm(),
        ],
      ),
    );
  }
}

class PickImage extends StatelessWidget {
  const PickImage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (image == null) {
                return;
              }
              provider.setFileImage(File(image.path));
            },
            child: Text(
              AppLocalizations.of(context)!.openCamera,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.or,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () async {
              final image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image == null) {
                return;
              }
              provider.setFileImage(File(image.path));
            },
            child: Text(
              AppLocalizations.of(context)!.pickAnImage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
            //style: ButtonStyle(textStyle: ),
          ),
        ),
      ],
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black45,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          AppLocalizations.of(context)!.or,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.titleTextStyle!.color,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}
