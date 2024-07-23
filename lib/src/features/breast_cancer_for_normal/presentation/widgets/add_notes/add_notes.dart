import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/builders/image_picker.dart';

import '../../../domain/entities/note.dart';
import '../../providers/add_notes_state_provider.dart';

import '../custom_texts.dart';
import 'finish_button.dart';
import 'image_with_clear_badge.dart';
import 'note_button.dart';
import 'note_text_field.dart';
import 'record_and_play_voice.dart';

class AddNotes extends StatelessWidget {
  const AddNotes(this.finding, {super.key});

  final Findings finding;

  @override
  Widget build(BuildContext context) {
    final addNoteState =
        Provider.of<AddNotesStateProvider>(context, listen: false);

    return Column(
      children: [
        TextTitle(
          data: AppLocalizations.of(context)!.addNotes,
          fontSize: 22,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoteButton(
              icon: Icons.note_alt_rounded,
              tooltip: AppLocalizations.of(context)!.textNote,
              onTap: () =>
                  showNoteDialog(context, child: NoteTextField(addNoteState)),
            ),
            NoteButton(
              icon: Icons.mic_external_on,
              tooltip: AppLocalizations.of(context)!.voiceNote,
              onTap: () => showBottomSheet(
                context,
                child: RecordAndPlayVoice(addNoteState),
              ),
            ),
            NoteButton(
              icon: Icons.camera_alt,
              tooltip: AppLocalizations.of(context)!.selectImage,
              onTap: () async {
                final imageFile =
                    await myImagePicker(context, imageQuality: 80);
                if (imageFile == null) {
                  return;
                }

                addNoteState.setImage(imageFile.path);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const ImageWithClearBadge(),
        const SizedBox(height: 20),
        FinishButton(finding),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
///////////////////// builders used above //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void showNoteDialog(BuildContext context, {required Widget child}) async {
  WakelockPlus.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 500,
          ),
          child: child,
        ),
      );
    },
  );

  WakelockPlus.disable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
}

/////////////////////////////////////////////////
/////////////////////////////////////////////////

void showBottomSheet(BuildContext context, {required Widget child}) async {
  WakelockPlus.enable();

  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )),
    enableDrag: false,
    builder: (context) {
      return SizedBox(height: 170, child: child);
    },
  );

  WakelockPlus.disable();
}
