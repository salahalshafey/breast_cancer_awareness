import 'dart:io';

import 'package:breast_cancer_awareness/src/core/util/builders/image_picker.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/image_container.dart';
import 'package:flutter/material.dart';

class SecondSignUpScreen extends StatefulWidget {
  static const routName = '/sign-up2';

  const SecondSignUpScreen({super.key});

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
  File? _image;
  String _userType = "normal";

  @override
  Widget build(BuildContext context) {
    final m = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: -30,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/images/background_cancer_sympol.png",
                scale: 1.5,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            children: [
              const SizedBox(height: 50),
              _image == null
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/person_avatar.png",
                        scale: 1.5,
                        filterQuality: FilterQuality.high,
                      ),
                    )
                  : ImageContainer(
                      image: _image!.path,
                      imageSource: From.file,
                      radius: 100,
                      shape: BoxShape.circle,
                      fit: BoxFit.cover,
                      border: Border.all(
                        color: const Color.fromRGBO(203, 100, 140, 1),
                        width: 2,
                      ),
                      showHighlight: true,
                      showImageDialoge: true,
                    ),
              const SizedBox(height: 10),
              Align(
                child: ElevatedButton(
                  onPressed: () async {
                    final imageXFile = await myImagePicker(context);
                    if (imageXFile == null) {
                      return;
                    }

                    setState(() {
                      _image = File(imageXFile.path);
                    });
                  },
                  child: const Text("Choose Image"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
