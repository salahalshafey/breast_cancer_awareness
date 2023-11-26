import '../classes/pair_class.dart';

/// ## This function takes three parameters:
/// * [string] A string to be analyzed.
/// * [patterns] A list of Pattern objects representing regular expressions or patterns to match in the string.
/// * [types] A list of generic type T, which is intended to represent types associated with each pattern.
///   -  Every [Pattern] index in [patterns] is associated with to type[T] index in [types].
///   - [types.length] Must be greater than [patterns.length] by one, this one represents the normal `the substring that didn't match with any of [patterns]`
///   - If [types.length] equals or less than [patterns.length], [Exception] will be thrown.
///
/// ## very important notes:
/// * this function does not have the capability of detecting nested patterns like for example `phone number inside highlighted ``.` **if you have patterns to detect phone number and highlighted ``.**
/// * If the [string] has in it nested [patterns], the [Pattern] that came first in[string] will win.
///
/// ## An example to explain the above:-
/// ```
/// patternMatcher(
///        data,
///        patterns: [
///          // bold
///          RegExp(
///            r"\*\*.*?\*\*",
///            multiLine: true,
///            dotAll: true,
///          ),
///
///          // highlighted
///          RegExp(
///            r"`.+?`",
///            multiLine: true,
///            dotAll: true,
///          ),
///
///          // url
///          RegExp(
///            r"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})",
///          ),
///
///          // email
///          RegExp(
///         r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}",
///          ),
///
///          // phone number (Egypt or global)
///          RegExp(
///            r"(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{2,3}\)?[\s.-]?\d{3,4}[\s.-]?\d{3,5}",
///          ),
///        ],
///        types: [
///          StringTypes.bold,
///          StringTypes.highlighted,
///          StringTypes.url,
///          StringTypes.email,
///          StringTypes.phoneNumber,
///          StringTypes.normal,
///        ],
/// ```

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
    final patternMatches =
        patterns[i].allMatches(myText).map((match) => Pair(match, types[i]));

    allMatches.addAll(patternMatches);

    myText = myText.replaceAllMapped(
      patterns[i],
      (match) => ''.padLeft(match.end - match.start),
    );
  }

  allMatches.sort((p1, p2) => p1.first.start.compareTo(p2.first.start));

  List<StringWithType<T>> allStringsWithType = [];
  int i = 0;
  for (final match in allMatches) {
    /// if the [string] has in it nested [patterns], the [Pattern] that came first in[string] will win.
    if (i > match.first.start) {
      continue;
    }

    // add normal string first
    allStringsWithType.add(StringWithType(
      string.substring(i, match.first.start),
      types.last,
    ));

    // add the string that has match with pattern
    allStringsWithType.add(StringWithType(
      string.substring(match.first.start, match.first.end),
      match.second,
    ));

    i = match.first.end;
  }

  // add remaining normal string if any
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
          .trim()
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
