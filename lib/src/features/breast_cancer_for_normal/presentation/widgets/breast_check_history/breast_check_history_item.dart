// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../../core/util/functions/date_time_and_duration.dart';
import '../../../../account/presentation/widgets/icon_from_asset.dart';

import '../../../../account/presentation/providers/account.dart';
import '../../providers/notes.dart';
import '../../../domain/entities/note.dart';

import '../../pages/breast_check_history/breast_check_note_screen.dart';
import '../../../../../core/util/builders/go_to_screen_with_slide_transition.dart';

class BreastCheckHistorytem extends StatelessWidget {
  const BreastCheckHistorytem(this.note, {super.key});

  final Note note;

  Future<bool?> _confirmDeleteNoteDialog(BuildContext context) {
    return showCustomAlretDialog<bool>(
      context: context,
      title: "Are you sure?",
      content: "Confirm Deletion?",
      titleColor: Colors.red,
      actionsBuilder: (dialogContext) => [
        ElevatedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(true);
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          child: const Text("Delete"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(dialogContext).pop(false);
          },
          style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.red),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.red)),
          ),
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  Future<void> _deleteNote(BuildContext context) async {
    final userId = Provider.of<Account>(context, listen: false).userId;
    final notesHistory = Provider.of<Notes>(context, listen: false);

    try {
      await notesHistory.deleteNote(userId, note.id);
    } catch (error) {
      showCustomAlretDialog(
        context: context,
        title: "Error",
        titleColor: Colors.red.shade900,
        content: error.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        color: Colors.red.shade900,
        child: const Icon(
          Icons.delete,
          size: 50,
          color: MyColors.appBarForGroundColor,
        ),
      ),
      confirmDismiss: (direction) => _confirmDeleteNoteDialog(context),
      onDismissed: (direction) => _deleteNote(context),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        onTap: () => goToScreenWithSlideTransition(
          context,
          BreastCheckNoteScreen(note),
        ),
        title: Row(
          children: [
            Hero(
              tag: note.id,
              child: IconFromAsset(
                assetIcon: note.finding == "All is well"
                    ? "assets/breast_cancer/all_is_well.png"
                    : note.finding == "Not sure"
                        ? "assets/breast_cancer/not_sure.png"
                        : "assets/breast_cancer/noticed_something.png",
                iconHeight: 60,
                opacity:
                    Theme.of(context).brightness == Brightness.dark ? 0.7 : 1,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                wellFormattedDateTimeLong(
                  note.dateOfNote,
                  seperateByLine: true,
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
