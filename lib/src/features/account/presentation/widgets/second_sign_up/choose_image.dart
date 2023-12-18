import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/builders/image_picker.dart';
import '../../../../../core/util/widgets/image_container.dart';

import '../../providers/image_and_user_type_provider.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({super.key});

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  Future<void> _chooseImage(ImageAndUserTypeProvider provider) async {
    final imageXFile = await myImagePicker(context);
    if (imageXFile == null) {
      return;
    }

    provider.changeImage(imageXFile.path);
  }

  void _getCurrentUserSocialPhotoIfExists() async {
    final socialPhoto = FirebaseAuth.instance.currentUser?.photoURL;

    if (socialPhoto != null) {
      _getNetworkImageToFile(socialPhoto).then((imagePath) =>
          Provider.of<ImageAndUserTypeProvider>(context, listen: false)
              .changeImage(imagePath));
    }
  }

  @override
  void initState() {
    _getCurrentUserSocialPhotoIfExists();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageAndUserTypeProvider>(context);

    return Column(
      children: [
        AnimatedCrossFade(
          firstChild: Align(
            alignment: Alignment.topCenter,
            child: Transform.flip(
              flipX: Directionality.of(context) == TextDirection.rtl,
              child: Image.asset(
                "assets/images/person_avatar.png",
                height: 140,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          secondChild: ImageContainer(
            image: provider.currentImage == null
                ? "assets/images/person_avatar.png"
                : provider.currentImage!.path,
            imageSource: provider.currentImage == null ? From.asset : From.file,
            radius: 70,
            shape: BoxShape.circle,
            fit: BoxFit.cover,
            border: Border.all(
              color: const Color.fromRGBO(203, 100, 140, 1),
              width: 2,
            ),
            showHighlight: true,
            showImageDialoge: true,
            showImageScreen: true,
          ),
          crossFadeState: provider.currentImage == null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(seconds: 1),
        ),
        const SizedBox(height: 10),
        Align(
          child: ElevatedButton(
            onPressed: () => _chooseImage(provider),
            child: Text(
              provider.currentImage == null
                  ? AppLocalizations.of(context)!.selectImage
                  : AppLocalizations.of(context)!.changeImage,
            ),
          ),
        )
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////
///
///

Future<String> _getNetworkImageToFile(String imageUrl) async {
  final tempDir = await getTemporaryDirectory();
  String path = '${tempDir.path}/${imageUrl.hashCode}.jpeg';

  await Dio().download(imageUrl, path);

  return path;
}
