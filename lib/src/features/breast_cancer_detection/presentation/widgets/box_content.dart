import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../core/util/functions/general_functions.dart';
import '../providers/for_doctor_screen_state_provider.dart';

import 'link_form.dart';

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
              fontSize: 16,
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
              fontSize: 16,
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
            fontSize: 18,
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

class ReadLinkByQRCode extends StatelessWidget {
  const ReadLinkByQRCode({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context, listen: false);

    return TextButton(
      onPressed: () async {
        // read QR Code
        // check if link is valid image (find a way without download)
        // if not valid show error (alret dialog), then return
        // if valid: provider.setNetworkImage("imageUrl");
        final imagelink =
            "https://firebasestorage.googleapis.com/v0/b/servicesapp-e006f.appspot.com/o/chat%2F2oUTBQRGiD9rZOAbHFNg%2F2022-08-13%2002%3A54%3A00.921322?alt=media&token=c19f1256-cc17-4a67-9493-7221d7a25006";
        final error = await validateImageLink(imagelink);
        if (error != null) {
          // ignore: use_build_context_synchronously
          showCustomAlretDialog(
            context: context,
            title: "Error",
            content: error,
            titleColor: Colors.red,
          );
          return;
        }

        provider.setNetworkImage(imagelink);
      },
      child: Text(
        "Get Image Link By Reading QR Code",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).appBarTheme.titleTextStyle!.color,
        ),
      ),
      //style: ButtonStyle(textStyle: ),
    );
  }
}
