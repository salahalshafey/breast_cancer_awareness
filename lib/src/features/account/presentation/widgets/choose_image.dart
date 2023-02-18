import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/util/builders/image_picker.dart';
import '../../../../core/util/widgets/image_container.dart';
import '../providers/image_and_user_type.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({super.key});

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  File? _currentImage;
  File? _previousImage;

  Future<void> _chooseImage(ImageAndUserType provider) async {
    final imageXFile = await myImagePicker(context);
    if (imageXFile == null) {
      return;
    }

    setState(() {
      _previousImage = _currentImage;
      _currentImage = File(imageXFile.path);
    });

    provider.changeImage(imageXFile.path);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageAndUserType>(context, listen: false);

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            _previousImage == null
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/person_avatar.png",
                      height: 140,
                      filterQuality: FilterQuality.high,
                    ),
                  )
                    .animate(
                      onPlay: (controller) {},
                    )
                    .fadeOut(
                        duration:
                            _previousImage == null && _currentImage == null
                                ? 0.0.seconds
                                : 1.5.seconds)
                : ImageContainer(
                    image: _previousImage!.path,
                    imageSource: From.file,
                    radius: 70,
                    shape: BoxShape.circle,
                    fit: BoxFit.cover,
                    border: Border.all(
                      color: const Color.fromRGBO(203, 100, 140, 1),
                      width: 2,
                    ),
                    showHighlight: true,
                    showImageDialoge: true,
                  )
                    .animate(
                      onPlay: (controller) {},
                    )
                    .fadeOut(duration: 1.5.seconds),
            _currentImage == null
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/person_avatar.png",
                      height: 140,
                      filterQuality: FilterQuality.high,
                    ),
                  )
                    .animate(
                        onPlay: (controller) {},
                        delay: _previousImage == null && _currentImage == null
                            ? 0.0.seconds
                            : 1.5.seconds)
                    .fadeIn(
                        duration:
                            _previousImage == null && _currentImage == null
                                ? 0.0.seconds
                                : 1.5.seconds)
                : ImageContainer(
                    image: _currentImage!.path,
                    imageSource: From.file,
                    radius: 70,
                    shape: BoxShape.circle,
                    fit: BoxFit.cover,
                    border: Border.all(
                      color: const Color.fromRGBO(203, 100, 140, 1),
                      width: 2,
                    ),
                    showHighlight: true,
                    showImageDialoge: true,
                  )
                    .animate(onPlay: (controller) {}, delay: 1.5.seconds)
                    .fadeIn(duration: 1.5.seconds)
          ],
        ),
        const SizedBox(height: 10),
        Align(
          child: ElevatedButton(
            onPressed: () => _chooseImage(provider),
            child: const Text("Choose Image"),
          ),
        )
      ],
    );
  }
}
