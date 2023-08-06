import 'package:breast_cancer_awareness/src/core/util/functions/date_time_and_duration.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../widgets/custom_texts.dart';

class NotesAndReminderScreen extends StatelessWidget {
  static const routName = '/notes-and-reminder-screen';

  const NotesAndReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final finding = ModalRoute.of(context)!.settings.arguments as String;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: DefaultScreen(
        containingBackgroundCancerSympol: false,
        containingAppBar: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          children: [
            const SizedBox(height: 20),
            TextTitle(
              data: finding != "All is well" ? "Don't worry" : "Next reminder",
              fontSize: 24,
              color: const Color.fromRGBO(199, 40, 107, 1),
            ),
            const SizedBox(height: 20),
            TextNormal(
              data: finding != "All is well"
                  ? "If you noticed anything unusual when examining your breasts, "
                      "stay calm! Check the area again after your next menstruation. "
                      "If the change persists, you should see a doctor.\n\n"
                      "Do you want to be reminded to check again in 2 weeks?"
                  : "You will automatically be reminded of your next self-check.\n\n"
                      "This is on:",
              fontSize: 22,
            ),
            const SizedBox(height: 20),
            if (finding == "All is well")
              TextTitle(
                data: longFormattedDateTime(
                  getCurrentDateTimeremovedMinutesAndSeconds()
                      .add(const Duration(days: 14)),
                ),
                fontSize: 22,
              ),
            if (finding != "All is well")
              Align(
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 100)),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 40),
            const Placeholder(),
          ],
        ),
      ),
    );
  }
}
