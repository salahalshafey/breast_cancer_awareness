import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/util/widgets/image_container.dart';

import '../providers/for_doctor_screen_state_provider.dart';

class ImageFromFile extends StatelessWidget {
  const ImageFromFile({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<ForDoctorScreenState>(context);

    return Stack(
      children: [
        ImageContainer(
          image: imagePath,
          imageSource: From.file,
          radius: screenSize.width * 0.5,
          borderRadius: BorderRadius.circular(10),
          fit: BoxFit.cover,
          showHighlight: true,
          showImageScreen: true,
        ).animate().fadeIn(duration: 1.seconds),
        PositionedDirectional(
          top: -10,
          end: -10,
          child: IconButton(
            tooltip: AppLocalizations.of(context)!.clearTheImage,
            onPressed: provider.resetBox,
            icon: const Icon(
              Icons.close,
              size: 30,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageFromNetwork extends StatelessWidget {
  const ImageFromNetwork({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<ForDoctorScreenState>(context);

    return Stack(
      children: [
        ImageContainer(
          image: imageUrl,
          imageSource: From.network,
          radius: screenSize.width * 0.5,
          borderRadius: BorderRadius.circular(10),
          fit: BoxFit.cover,
          showHighlight: true,
          showImageScreen: true,
          showLoadingIndicator: true,
          showLoadingProgress: true,
        ),
        PositionedDirectional(
          top: -10,
          end: -10,
          child: IconButton(
            tooltip: AppLocalizations.of(context)!.clearTheImage,
            onPressed: provider.resetBox,
            icon: const Icon(
              Icons.close,
              size: 30,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
