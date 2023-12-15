import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ? "Your reminder has been set:"
      : "Do you want to be reminded to check again in 2 weeks?";

  void _setLocalNotificationEveryTwoWeeks() async {
    await Noti.initialize();
    Noti.showBigTextNotification(
      title: "Self-Check",
      body: "Your next self-check is due.",
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
                    ? "Don't worry"
                    : "Next reminder",
                fontSize: 24,
                color: const Color.fromRGBO(199, 40, 107, 1),
              ),
              const SizedBox(height: 20),
              TextNormal(
                data: finding != Findings.allIsWell
                    ? "If you noticed anything unusual when examining your breasts, "
                        "stay calm! Check the area again after your next menstruation. "
                        "If the change persists, you should see a doctor.\n\n"
                        "$_reminder"
                    : "You will automatically be reminded of your next self-check.\n\n"
                        "This is on:",
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
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(260))),
                    child: const Text(
                      "OK",
                      style: TextStyle(
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
