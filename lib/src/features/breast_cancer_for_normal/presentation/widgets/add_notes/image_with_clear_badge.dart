import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/util/widgets/image_container.dart';

import '../../providers/add_notes_state_provider.dart';

class ImageWithClearBadge extends StatelessWidget {
  const ImageWithClearBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final addNoteState = Provider.of<AddNotesStateProvider>(context);

    return addNoteState.imageFilePath == null
        ? const SizedBox(height: 60)
        : Stack(
            children: [
              ImageContainer(
                image: addNoteState.imageFilePath!,
                imageSource: From.file,
                radius: 150,
                showImageScreen: true,
                imageCaption: addNoteState.text,
                borderRadius: BorderRadius.circular(25),
                showHighlight: true,
                containingShadow: true,
                fit: BoxFit.cover,
              ),
              PositionedDirectional(
                top: 0,
                end: 0,
                child: Transform.translate(
                  offset: Offset(
                    Directionality.of(context) == TextDirection.rtl ? -12 : 12,
                    -12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: AppLocalizations.of(context)!.clearTheImage,
                      onPressed: () => addNoteState.setImage(null),
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
