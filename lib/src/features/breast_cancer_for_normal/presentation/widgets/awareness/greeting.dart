import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            if (snapshot.hasError || snapshot.data == null) {
              return const TextTitle(data: "Hello", fontSize: 24);
            }

            final userName = wellFormatedString(snapshot.data!.firstName);
            return TextTitle(data: "Hello $userName", fontSize: 24);
          },
        ),
        const SizedBox(height: 30),
        const TextNormal(
          data:
              "You understand that every day counts when it comes to early breast cancer detection."
              " it's great that you take responsibility for your health and check your breasts regularly.",
          fontSize: 20,
        ),
      ],
    );
  }
}
