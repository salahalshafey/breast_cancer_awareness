import '../classes/pair_class.dart';

/// ## This function takes three parameters:
/// * **string:** A string to be analyzed.
/// * **patterns:** A list of Pattern objects representing regular expressions or patterns to match in the string.
/// * **types:** A list of generic type T, which is intended to represent types associated with each pattern.

List<StringWithType<T>> patternMatcher<T>(
  String string, {
  required List<Pattern> patterns,
  required List<T> types,
}) {
  if (types.length <= patterns.length) {
    throw Exception("types length must be more than patterns length!!");
  }

  List<Pair<Match, T>> allMatches = [];
  String myText = string;

  for (int i = 0; i < patterns.length; i++) {
    final patternMatches = patterns[i]
        .allMatches(myText)
        .map((urlMatch) => Pair(urlMatch, types[i]));

    allMatches.addAll(patternMatches);
    myText = myText.replaceAllMapped(
        patterns[i], (match) => ''.padLeft(match.end - match.start));
  }

  allMatches.sort((p1, p2) => p1.first.start.compareTo(p2.first.start));

  List<StringWithType<T>> allStringsWithType = [];
  int i = 0;
  for (final match in allMatches) {
    allStringsWithType.add(StringWithType(
      string.substring(i, match.first.start),
      types.last,
    ));

    allStringsWithType.add(StringWithType(
      string.substring(match.first.start, match.first.end),
      match.second,
    ));
    i = match.first.end;
  }

  allStringsWithType.add(StringWithType(
    string.substring(i),
    types.last,
  ));

  return allStringsWithType;
}

class StringWithType<T> {
  const StringWithType(this.string, this.type);

  final String string;
  final T type;

  @override
  String toString() {
    return "\n$type \n$string\n";
  }
}

String wellFormatedString(String str) {
  return str.trim().isEmpty
      ? str
      : str
          .split(RegExp(r' +'))
          .map(
            (word) =>
                word.substring(0, 1).toUpperCase() +
                word.substring(1).toLowerCase(),
          )
          .join(' ');
}

String firstName(String fullName) => fullName.split(RegExp(r' +')).first;

bool firstCharIsArabic(String text) {
  if (text.isEmpty) {
    return false;
  }

  final arabicChars = 'ا؟؛أإءئؤآبتثةجحخدذرزسشصضطظعغفقكلمنهويلالآى'.toSet();
  final englishChars =
      'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM'.toSet();

  final listOfText = text.toList();

  for (final char in listOfText) {
    if (arabicChars.contains(char)) {
      return true;
    }
    if (englishChars.contains(char)) {
      return false;
    }
  }

  return false; // if all chars is special chars
}

extension on String {
  Set<String> toSet() => {for (int i = 0; i < length; i++) substring(i, i + 1)};

  List<String> toList() =>
      [for (int i = 0; i < length; i++) substring(i, i + 1)];
}
