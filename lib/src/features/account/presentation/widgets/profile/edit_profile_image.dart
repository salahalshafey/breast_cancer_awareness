import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/util/widgets/image_container.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({
    super.key,
    required this.fileImagePath,
    required this.imageTitle,
    required this.imageCaption,
    required this.chooseImage,
    required this.clearTheImage,
  });

  final String? fileImagePath;
  final String imageTitle;
  final String? imageCaption;
  final void Function() chooseImage;
  final void Function() clearTheImage;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Stack(
        children: [
          ImageContainer(
            image: fileImagePath ?? "assets/images/person_avatar.png",
            imageSource: fileImagePath == null ? From.asset : From.file,
            radius: 80,
            saveNetworkImageToLocalStorage: kIsWeb ? false : true,
            shape: BoxShape.circle,
            border: Border.all(color: const Color.fromRGBO(191, 76, 136, 1)),
            showHighlight: true,
            showLoadingIndicator: true,
            showImageScreen: fileImagePath == null ? false : true,
            imageTitle: imageTitle,
            imageCaption: imageCaption,
          ),
          PositionedDirectional(
            bottom: -10,
            start: 49,
            child: IconButton(
              tooltip: fileImagePath == null
                  ? AppLocalizations.of(context)!.selectImage
                  : AppLocalizations.of(context)!.changeImage,
              onPressed: chooseImage,
              icon: Container(
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 40,
                  color: MyColors.primaryColor,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: -10,
            end: -10,
            child: IconButton(
              tooltip: AppLocalizations.of(context)!.clearTheImage,
              onPressed: clearTheImage,
              icon: Container(
                decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 40,
                  color: MyColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
