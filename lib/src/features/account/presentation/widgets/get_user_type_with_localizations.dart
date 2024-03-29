import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/user_information.dart';

import '../../../../app.dart';

String getuserTypeWithLocalizations(UserTypes userType) {
  final context = navigatorKey.currentContext!;

  switch (userType) {
    case UserTypes.doctor:
      return AppLocalizations.of(context)!.doctor;
    case UserTypes.patient:
      return AppLocalizations.of(context)!.patient;
    case UserTypes.normal:
      return AppLocalizations.of(context)!.normal;
    default:
      return AppLocalizations.of(context)!.normal;
  }
}
