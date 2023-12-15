import 'package:flutter/material.dart';

import '../../../../../core/util/functions/date_time_and_duration.dart';
import '../../../../../core/util/widgets/default_screen.dart';
import '../../../../../core/util/widgets/image_container.dart';
import '../../../../account/presentation/widgets/icon_from_asset.dart';

import '../../../domain/entities/note.dart';
import '../../../../../core/util/widgets/note_description.dart';
import '../../widgets/audio_player.dart';
import '../../widgets/breast_check_history/breast_check_history_item.dart';

class BreastCheckNoteScreen extends StatefulWidget {
  const BreastCheckNoteScreen(this.note, {super.key});

  final Note note;

  @override
  State<BreastCheckNoteScreen> createState() => _BreastCheckNoteScreenState();
}

class _BreastCheckNoteScreenState extends State<BreastCheckNoteScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? (screenWidth - 600) / 2 + 20 : 20;

    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      child: ListView.builder(
        padding:
            EdgeInsets.symmetric(vertical: 40, horizontal: horizontalPadding),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 60),
              Hero(
                tag: widget.note.id,
                child: IconFromAsset(
                  assetIcon: findingsIconFromAsset(widget.note.finding),
                  iconHeight: 110,
                  opacity:
                      Theme.of(context).brightness == Brightness.dark ? 0.7 : 1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                wellFormattedDateTimeLong(
                  widget.note.dateOfNote,
                  seperateByLine: isportrait ? true : false,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isportrait ? 20 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              NoteDescription(
                icon: const Icon(Icons.note_alt_rounded, size: 40),
                title: "Text Note",
                description: widget.note.text,
              ),
              const SizedBox(height: 20),
              NoteDescription(
                icon: const Icon(Icons.record_voice_over, size: 40),
                title: "Voice Note",
                child: widget.note.recorderFilePath == null
                    ? null
                    : AudioPlayer(
                        recorderFilePath: widget.note.recorderFilePath!,
                      ),
              ),
              const SizedBox(height: 20),
              if (widget.note.imageFilePath != null)
                ImageContainer(
                  image: widget.note.imageFilePath!,
                  imageSource: From.file,
                  radius: (screenWidth - horizontalPadding * 2) / 2,
                  showImageScreen: true,
                  imageCaption: widget.note.text,
                  borderRadius: BorderRadius.circular(25),
                  showHighlight: true,
                  containingShadow: true,
                  fit: BoxFit.cover,
                ),
            ],
          );
        },
      ),
    );
  }
}
