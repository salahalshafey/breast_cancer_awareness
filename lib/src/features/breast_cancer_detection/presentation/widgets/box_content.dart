import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/for_doctor_screen_state_provider.dart';

import 'link_form.dart';
import 'read_link_by_qr_code.dart';

class BoxContent extends StatelessWidget {
  const BoxContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: const [
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
        TextButton(
          onPressed: () async {
            final image =
                await ImagePicker().pickImage(source: ImageSource.camera);
            if (image == null) {
              return;
            }
            provider.setFileImage(File(image.path));
          },
          child: Text(
            "Open Camera",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).appBarTheme.titleTextStyle!.color,
            ),
          ),
        ),
        const Text(
          " Or ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        TextButton(
          onPressed: () async {
            final image =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image == null) {
              return;
            }
            provider.setFileImage(File(image.path));
          },
          child: Text(
            "Pick an Image",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).appBarTheme.titleTextStyle!.color,
            ),
          ),
          //style: ButtonStyle(textStyle: ),
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
          "Or",
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
