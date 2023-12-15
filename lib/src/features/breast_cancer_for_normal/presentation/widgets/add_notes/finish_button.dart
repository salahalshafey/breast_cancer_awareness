// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../domain/entities/note.dart';

import '../../../../account/presentation/providers/account.dart';
import '../../providers/add_notes_state_provider.dart';
import '../../providers/notes.dart';

class FinishButton extends StatefulWidget {
  const FinishButton(this.finding, {super.key});

  final Findings finding;

  @override
  State<FinishButton> createState() => _FinishButtonState();
}

class _FinishButtonState extends State<FinishButton> {
  bool _isLoading = false;

  Future<void> _saveNotes() async {
    final userId = Provider.of<Account>(context, listen: false).userId;
    final currentNotes =
        Provider.of<AddNotesStateProvider>(context, listen: false);
    final notesHistory = Provider.of<Notes>(context, listen: false);

    final currentDate = DateTime.now();
    final note = Note(
      id: currentDate.toString().hashCode.toString(),
      finding: widget.finding,
      text: currentNotes.text,
      recorderFilePath: currentNotes.recordFilePath,
      imageFilePath: currentNotes.imageFilePath,
      dateOfNote: currentDate,
    );
    try {
      setState(() {
        _isLoading = true;
      });

      await notesHistory.addNote(userId, note);

      Navigator.of(context).pop();
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      showCustomAlretDialog(
        context: context,
        title: "Error",
        titleColor: Colors.red,
        content: error.toString(),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveNotes,
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size.fromWidth(260)),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3.0,
                ),
              )
            : const Text(
                "FINISH",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
