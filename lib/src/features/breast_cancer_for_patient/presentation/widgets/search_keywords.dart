import 'package:flutter/material.dart';

class SearchKeyWords extends StatelessWidget {
  const SearchKeyWords(
    this.setSearchWord, {
    super.key,
  });

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
              style: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 16)),
                padding: MaterialStatePropertyAll(EdgeInsets.all(8.0)),
              ),
              child: Text(_keyWords[index]),
            ),
          );
        },
      ),
    );
  }
}
