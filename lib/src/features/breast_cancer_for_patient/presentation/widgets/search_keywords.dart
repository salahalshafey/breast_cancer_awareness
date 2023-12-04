import 'package:breast_cancer_awareness/src/core/util/functions/string_manipulations_and_search.dart';
import 'package:flutter/material.dart';

class SearchKeyWords extends StatelessWidget {
  const SearchKeyWords(
    this.searchWord,
    this.setSearchWord, {
    super.key,
  });

  final String? searchWord;
  final void Function(String searchWord, {bool textToSpeech}) setSearchWord;

  final _keyWords = const [
    "Breast Cancer Symptoms",
    "Breast Cancer Stages",
    "Breast Cancer Treatment Options",
    "Breast Cancer Support Groups",
    "Breast Cancer Survivor Stories",
    "Breast Cancer Research",
    "Breast Cancer Awareness",
    "Breast Cancer Organizations",
    "Breast Cancer Diet and Nutrition",
    "Breast Cancer Exercise and Fitness",
    "Breast Reconstruction",
    "Breast Cancer Side Effects",
    "Breast Cancer Medications",
    "Breast Cancer Financial Support",
    "Breast Cancer Mental Health",
    "Breast Cancer Screening Guidelines",
    "Breast Cancer in Men",
    "Breast Cancer Risk Factors",
    "Breast Cancer Family History",
    "Breast Cancer Prevention",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _keyWords.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () => setSearchWord(_keyWords[index]),
              style: ButtonStyle(
                textStyle:
                    const MaterialStatePropertyAll(TextStyle(fontSize: 16)),
                padding: const MaterialStatePropertyAll(EdgeInsets.all(8.0)),
                backgroundColor: MaterialStatePropertyAll(
                  _keyWords[index].isTheSameAS(searchWord)
                      ? const Color.fromRGBO(181, 11, 99, 1)
                      : null,
                ),
              ),
              child: Text(_keyWords[index]),
            ),
          );
        },
      ),
    );
  }
}

extension on String {
  bool isTheSameAS(String? other) =>
      wellFormatedString(this) == wellFormatedString(other ?? "");
}
