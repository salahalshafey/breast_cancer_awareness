import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../../../core/util/widgets/default_screen.dart';

import '../../../../account/presentation/providers/account.dart';
import '../../providers/notes.dart';

import '../../widgets/breast_check_history/breast_check_history_item.dart';
import '../../widgets/breast_check_history/empty_shape.dart';

class BreastCheckHistoryScreen extends StatelessWidget {
  const BreastCheckHistoryScreen({super.key});

  void _deleteAllSelfChecks(
      BuildContext context, String userId, Notes notesHistory) async {
    if (notesHistory.getAllNotes().isEmpty) {
      return;
    }

    final delete = await _showConfirmDeletionDialog(context);
    if (delete == null || delete == false) {
      return;
    }

    notesHistory.deleteAllNotes(userId);
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<Account>(context, listen: false).userId;
    final notesHistory = Provider.of<Notes>(context, listen: false);

    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      appBarActions: [
        IconButton(
          onPressed: () => _deleteAllSelfChecks(context, userId, notesHistory),
          icon: const Icon(Icons.delete),
          tooltip: AppLocalizations.of(context)!.deleteAllSelfchecks,
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            AppLocalizations.of(context)!.mySelfchecks,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: notesHistory.fetchAllNotes(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                final notes = Provider.of<Notes>(context).getAllNotes();

                if (notes.isEmpty) {
                  return const Center(
                    child: EmptyShape(),
                  );
                }

                final screenWidth = MediaQuery.of(context).size.width;
                final double horizontalPadding =
                    screenWidth > 500 ? (screenWidth - 500) / 2 + 20 : 20;

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: horizontalPadding,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return BreastCheckHistorytem(notes[index])
                        .animate(delay: ((index + 1) * 100).ms)
                        .fade()
                        .slideY();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////
///
///

Future<bool?> _showConfirmDeletionDialog(BuildContext context) {
  final textDirection = Directionality.of(context) == TextDirection.rtl
      ? AppLocalizations.of(context)!.fromRightToLeft
      : AppLocalizations.of(context)!.fromLeftToRight;

  return showCustomAlretDialog<bool>(
    context: context,
    constraints: const BoxConstraints(maxWidth: 500),
    title: AppLocalizations.of(context)!.warning,
    content: AppLocalizations.of(context)!
        .areYouSureOfDeletingAllYourSelfchecks(textDirection),
    actionsPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    actionsBuilder: (dialogContext) => [
      ElevatedButton(
        onPressed: () {
          Navigator.of(dialogContext).pop(true);
        },
        style: ButtonStyle(
          //  padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          // fixedSize: const MaterialStatePropertyAll(Size.fromWidth(130)),
          backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
        ),
        child: Text(
          AppLocalizations.of(context)!.deleteAll,
          textAlign: TextAlign.center,
        ),
      ),
      OutlinedButton(
        onPressed: () {
          Navigator.of(dialogContext).pop(false);
        },
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.red.shade900),
          // padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          // fixedSize: const MaterialStatePropertyAll(Size.fromWidth(110)),
          side:
              MaterialStatePropertyAll(BorderSide(color: Colors.red.shade900)),
        ),
        child: Text(
          AppLocalizations.of(context)!.cancel,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
