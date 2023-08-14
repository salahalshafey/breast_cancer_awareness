import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../../core/util/builders/image_picker.dart';

import '../../providers/add_notes_state_provider.dart';

import '../custom_texts.dart';
import 'image_with_clear_badge.dart';
import 'note_button.dart';
import 'note_text_field.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final addNoteState =
        Provider.of<AddNotesStateProvider>(context, listen: false);
    //final notesHistory = Provider

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
              onTap: () => showNoteDialog(context, child: const Text("data")),
            ),
            NoteButton(
              icon: Icons.camera_alt,
              onTap: () async {
                final imageFile =
                    await myImagePicker(context, imageQuality: 100);
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
        Align(
          child: ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
              fixedSize: MaterialStatePropertyAll(Size.fromWidth(260)),
            ),
            child: const Text("FINISH",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

Future<void> showNoteDialog(BuildContext context,
    {required Widget child}) async {
  Wakelock.enable();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 260,
          width: 200,
          child: child,
        ),
      );
    },
  );

  Wakelock.disable();
}
