import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../app.dart';

class LocaleWithCountryFlage {
  final String languageCode;
  final String languageFullName;
  final String countryFlage;

  const LocaleWithCountryFlage(
    this.languageCode,
    this.languageFullName,
    this.countryFlage,
  );
}

class Languages {
  /// All supported Locales only.
  ///
  static List<LocaleWithCountryFlage> get allLocaleWithDetails {
    final context = navigatorKey.currentContext!;

    return [
      LocaleWithCountryFlage(
        "en",
        AppLocalizations.of(context)!.english,
        "🇺🇸",
      ),
      LocaleWithCountryFlage(
        "ar",
        AppLocalizations.of(context)!.arabic,
        "🇪🇬",
      ),
    ];
  }

  /// All languages +50, whether in supported Locales or not.
  ///
  static List<LocaleWithCountryFlage> get allWithDetails {
    final context = navigatorKey.currentContext!;

    return [
      LocaleWithCountryFlage(
        "en",
        AppLocalizations.of(context)!.english,
        "🇺🇸",
      ),
      LocaleWithCountryFlage(
        "ar",
        AppLocalizations.of(context)!.arabic,
        "🇪🇬",
      ),
      LocaleWithCountryFlage(
        "fr",
        AppLocalizations.of(context)!.frensh,
        "🇫🇷",
      ),
    ];
  }
}
