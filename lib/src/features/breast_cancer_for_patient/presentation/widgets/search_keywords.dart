import 'package:flutter/material.dart';

import '../../../../app.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

class SearchKeyWords extends StatelessWidget {
  const SearchKeyWords(
    this.searchWord,
    this.setSearchWord, {
    super.key,
  });

  final String? searchWord;
  final void Function(String searchWord, {bool textToSpeech}) setSearchWord;

  List<String> get _keyWords {
    final context = navigatorKey.currentContext!;

    return [
      AppLocalizations.of(context)!.breastCancerSymptoms,
      AppLocalizations.of(context)!.breastCancerStages,
      AppLocalizations.of(context)!.breastCancerTreatmentOptions,
      AppLocalizations.of(context)!.breastCancerSupportGroups,
      AppLocalizations.of(context)!.breastCancerSurvivorStories,
      AppLocalizations.of(context)!.breastCancerResearch,
      AppLocalizations.of(context)!.breastCancerAwareness,
      AppLocalizations.of(context)!.breastCancerOrganizations,
      AppLocalizations.of(context)!.breastCancerDietAndNutrition,
      AppLocalizations.of(context)!.breastCancerExerciseAndFitness,
      AppLocalizations.of(context)!.breastReconstruction,
      AppLocalizations.of(context)!.breastCancerSideEffects,
      AppLocalizations.of(context)!.breastCancerMedications,
      AppLocalizations.of(context)!.breastCancerFinancialSupport,
      AppLocalizations.of(context)!.breastCancerMentalHealth,
      AppLocalizations.of(context)!.breastCancerScreeningGuidelines,
      AppLocalizations.of(context)!.breastCancerInMen,
      AppLocalizations.of(context)!.breastCancerRiskFactors,
      AppLocalizations.of(context)!.breastCancerFamilyHistory,
      AppLocalizations.of(context)!.breastCancerPrevention,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _keyWords.length,
        itemBuilder: (context, index) {
          return Align(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: ElevatedButton(
                onPressed: () => setSearchWord(_keyWords[index]),
                style: ButtonStyle(
                  textStyle:
                      const WidgetStatePropertyAll(TextStyle(fontSize: 16)),
                  padding: const WidgetStatePropertyAll(EdgeInsets.all(8.0)),
                  backgroundColor: WidgetStatePropertyAll(
                    _keyWords[index].isTheSameAS(searchWord)
                        ? const Color.fromRGBO(181, 11, 99, 1)
                        : null,
                  ),
                ),
                child: Text(_keyWords[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension IsThesameAs on String {
  bool isTheSameAS(String? other) =>
      wellFormatedString(this) == wellFormatedString(other ?? "");
}
