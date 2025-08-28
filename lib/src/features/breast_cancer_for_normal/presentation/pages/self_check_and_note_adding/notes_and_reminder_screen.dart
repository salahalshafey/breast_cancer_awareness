// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../core/util/functions/date_time_and_duration.dart';
import '../../../../../core/util/widgets/default_screen.dart';

import '../../../domain/entities/note.dart';
import '../../providers/add_notes_state_provider.dart';
import '../../providers/notification.dart';
import '../../../../settings/providers/settings_provider.dart';

import '../../widgets/add_notes/add_notes.dart';
import '../../widgets/custom_texts.dart';

class NotesAndReminderScreen extends StatefulWidget {
  static const routName = '/notes-and-reminder-screen';

  const NotesAndReminderScreen({super.key});

  @override
  State<NotesAndReminderScreen> createState() => _NotesAndReminderScreenState();
}

class _NotesAndReminderScreenState extends State<NotesAndReminderScreen> {
  bool _reminderSeted = false;

  String get _reminder => _reminderSeted
      ? AppLocalizations.of(context)!.yourReminderHasBeenSet
      : AppLocalizations.of(context)!.doYouWantToBeRemindedToCheckAgainIn(
          AppLocalizations.of(context)!.twoWeeks);

  void _setLocalNotificationEveryTwoWeeks() async {
    await Noti.initialize();
    Noti.showBigTextNotification(
      title: AppLocalizations.of(context)!.selfcheck,
      body: AppLocalizations.of(context)!.yourNextSelfcheckIsDue,
    ).then((_) {
      Provider.of<SettingsProvider>(context, listen: false)
          .changeNotification(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final finding = ModalRoute.of(context)!.settings.arguments as Findings;

    if (finding == Findings.allIsWell) {
      _setLocalNotificationEveryTwoWeeks();
    }

    return PopScope(
      canPop: false,
      child: ChangeNotifierProvider<AddNotesStateProvider>(
        create: (context) => AddNotesStateProvider(),
        child: DefaultScreen(
          containingBackgroundCancerSympol: false,
          containingAppBar: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            children: [
              const SizedBox(height: 20),
              TextTitle(
                data: finding != Findings.allIsWell
                    ? AppLocalizations.of(context)!.dontWorry
                    : AppLocalizations.of(context)!.nextReminder,
                fontSize: 24,
                color: const Color.fromRGBO(199, 40, 107, 1),
              ),
              const SizedBox(height: 20),
              TextNormal(
                data: finding != Findings.allIsWell
                    ? "${AppLocalizations.of(context)!.ifYouNoticedAnythingUnusualWhenExaminingYourBreasts}"
                        "$_reminder"
                    : AppLocalizations.of(context)!
                        .youWillAutomaticallyBeReminded,
                fontSize: 22,
              ),
              if (finding == Findings.allIsWell || _reminderSeted)
                TextTitle(
                  data: wellFormattedDateTimeLong(
                    DateTime.now().add(const Duration(days: 14)),
                    seperateByLine: true,
                  ),
                  fontSize: 22,
                ),
              if (finding != Findings.allIsWell && !_reminderSeted) ...[
                const SizedBox(height: 20),
                Align(
                  child: ElevatedButton(
                    onPressed: () {
                      _setLocalNotificationEveryTwoWeeks();
                      setState(() {
                        _reminderSeted = true;
                      });
                    },
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size.fromWidth(260))),
                    child: Text(
                      AppLocalizations.of(context)!.ok,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 40),
              AddNotes(finding),
            ],
          ),
        ),
      ),
    );
  }
}
