import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app.dart';

final context = navigatorKey.currentContext!;

String wellFormatedDistance(double distanceInMeter) {
  if (distanceInMeter >= 1000) {
    return '${(distanceInMeter / 1000).toStringAsFixed(1)} ${AppLocalizations.of(context)!.km}';
  }

  return '${distanceInMeter.toStringAsFixed(0)} ${AppLocalizations.of(context)!.meter}';
}

String fromMeterPerSecToKPerH(double speed) {
  return (speed * 3.6).toStringAsFixed(0);
}

String fromKilometerPerHourToMPerSec(double speed) {
  return (speed * (5 / 18)).toStringAsFixed(0);
}
