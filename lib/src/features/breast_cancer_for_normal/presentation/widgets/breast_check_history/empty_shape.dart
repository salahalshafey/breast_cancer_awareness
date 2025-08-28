import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class EmptyShape extends StatelessWidget {
  const EmptyShape({super.key});

  @override
  Widget build(BuildContext context) {
    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      children: <Widget>[
        const Expanded(flex: 1, child: SizedBox()),
        SizedBox(
          height: isportrait ? 150 : 100,
          child: Image.asset(
            'assets/images/empty.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.noActivityYet,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade800
                : null,
          ),
        ),
        const Expanded(flex: 3, child: SizedBox()),
      ],
    );
  }
}
