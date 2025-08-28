import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../core/util/functions/string_manipulations_and_search.dart';

import '../../../../account/presentation/providers/account.dart';
import '../custom_texts.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: Provider.of<Account>(context).getUserInfo(),
          builder: (context, snapshot) {
            final helloWord = AppLocalizations.of(context)!.hello;

            if (snapshot.hasError || snapshot.data == null) {
              return TextTitle(data: helloWord, fontSize: 24);
            }

            final userName = wellFormatedString(snapshot.data!.firstName);
            return TextTitle(data: "$helloWord $userName", fontSize: 24);
          },
        ),
        const SizedBox(height: 30),
        TextNormal(
          data: AppLocalizations.of(context)!
              .youUnderstandThatEveryDayCountsWhenItComesToEarlyBreastCancerDetection,
          fontSize: 20,
        ),
      ],
    );
  }
}
