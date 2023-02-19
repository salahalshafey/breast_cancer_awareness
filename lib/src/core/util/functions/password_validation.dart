import 'package:flutter/material.dart';

String? validatPassword(String? value) {
  const errorMessage =
      "Password must be at least 8 characters long, with at least 5 alphabet, 2 numbers and 1 special charachters like '~!@#\$%^&*()_'.";

  if (value == null || value.length < 8) {
    return errorMessage;
  }

  final alphabet =
      ("abcdefghijklmnopqrstuvwxyz${"abcdefghijklmnopqrstuvwxyz".toUpperCase()}")
          .characters
          .toSet();
  var countAlpha = 0;
  value.characters.toList().forEach((char) {
    if (alphabet.contains(char)) countAlpha++;
  });
  if (countAlpha < 5) {
    return errorMessage;
  }

  final numbers = "0123456789".characters.toSet();
  var countNum = 0;
  value.characters.toList().forEach((char) {
    if (numbers.contains(char)) countNum++;
  });
  if (countNum < 2) {
    return errorMessage;
  }

  final specialChar = "~!@#\$%^&*()_-+={}[]'\"\\;: ,.<>?/،؟".characters.toSet();
  var countSpecial = 0;
  value.characters.toList().forEach((char) {
    if (specialChar.contains(char)) countSpecial++;
  });
  if (countSpecial < 1) {
    return errorMessage;
  }

  return null;
}

String? validatPassword2(String? value) {
  if (value == null || value.trim().length < 8) {
    return 'Password must be at least 8 characters long.';
  }

  final alphabet =
      ("abcdefghijklmnopqrstuvwxyz${"abcdefghijklmnopqrstuvwxyz".toUpperCase()}")
          .characters
          .toSet();
  var countAlpha = 0;
  value.characters.toList().forEach((char) {
    if (alphabet.contains(char)) countAlpha++;
  });
  if (countAlpha < 5) {
    return "Password must contain at least 5 alphabet characters.";
  }

  final numbers = "0123456789".characters.toSet();
  var countNum = 0;
  value.characters.toList().forEach((char) {
    if (numbers.contains(char)) countNum++;
  });
  if (countNum < 2) {
    return "Password must contain at least 2 numbers.";
  }

  final specialChar = "~!@#\$%^&*()_-+={}[]'\"\\;: ,.<>?/،؟".characters.toSet();
  var countSpecial = 0;
  value.characters.toList().forEach((char) {
    if (specialChar.contains(char)) countSpecial++;
  });
  if (countSpecial < 1) {
    return "Password must contain at least 1 special charachters like '~!@#\$%^&*()_'.";
  }

  return null;
}

String? validatPassword3(String? value) {
  if (value == null || value.length < 8) {
    return "Password must be at least 8 characters long, with at least 5 alphabet, 2 numbers and 1 special charachters like '~!@#\$%^&*()_'.";
  }

  List<String> validationValues = [];

  final alphabet =
      ("abcdefghijklmnopqrstuvwxyz${"abcdefghijklmnopqrstuvwxyz".toUpperCase()}")
          .characters
          .toSet();
  var countAlpha = 0;
  value.characters.toList().forEach((char) {
    if (alphabet.contains(char)) countAlpha++;
  });
  if (countAlpha < 5) {
    validationValues.add("5 alphabet characters");
  }

  final numbers = "0123456789".characters.toSet();
  var countNum = 0;
  value.characters.toList().forEach((char) {
    if (numbers.contains(char)) countNum++;
  });
  if (countNum < 2) {
    validationValues.add("2 numbers");
  }

  final specialChar = "~!@#\$%^&*()_-+={}[]'\"\\;: ,.<>?/،؟".characters.toSet();
  var countSpecial = 0;
  value.characters.toList().forEach((char) {
    if (specialChar.contains(char)) countSpecial++;
  });
  if (countSpecial < 1) {
    validationValues.add("1 special charachters like '~!@#\$%^&*()_'.");
  }

  return _joinValidations(validationValues);
}

String? _joinValidations(List<String> validations) {
  if (validations.isEmpty) {
    return null;
  }

  const s = "Password must contain at least ";
  if (validations.length == 1) {
    return s + validations.join();
  } else {
    return "$s${validations.sublist(0, validations.length - 1).join(", ")} and ${validations.last}";
  }
}
