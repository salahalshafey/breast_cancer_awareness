import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../../core/util/builders/image_picker.dart';

import '../../providers/add_notes_state_provider.dart';

import '../custom_texts.dart';
import 'finish_button.dart';
import 'image_with_clear_badge.dart';
import 'note_button.dart';
import 'note_text_field.dart';
import 'record_and_play_voice.dart';

class AddNotes extends StatelessWidget {
  const AddNotes(this.finding, {super.key});

  final String finding;

  @override
  Widget build(BuildContext context) {
    final addNoteState =
        Provider.of<AddNotesStateProvider>(context, listen: false);

    return Column(
      children: [
        const TextTitle(
          data: "Add notes",
          fontSize: 22,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoteButton(
              icon: Icons.note_alt_rounded,
              onTap: () =>
                  showNoteDialog(context, child: NoteTextField(addNoteState)),
            ),
            NoteButton(
              icon: Icons.mic_external_on,
              onTap: () => showBottomSheet(
                context,
                child: RecordAndPlayVoice(addNoteState),
              ),
            ),
            NoteButton(
              icon: Icons.camera_alt,
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
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 270,
          width: 200,
          child: child,
        ),
      );
    },
  );

  Wakelock.disable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
}

/////////////////////////////////////////////////
/////////////////////////////////////////////////

void showBottomSheet(BuildContext context, {required Widget child}) async {
  Wakelock.enable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: const BeveledRectangleBorder(),
    enableDrag: false,
    builder: (context) {
      return SizedBox(height: 170, child: child);
    },
  );

  Wakelock.disable();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
}
