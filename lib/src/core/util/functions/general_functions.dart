// general-purpose functions will be here

import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:breast_cancer_awareness/src/core/network/network_info.dart';

/// * if link doesn't point to a valid image will return String containing error info
/// * if valid will return a null

Future<String?> validateImageLink(String url) async {
  if (await NetworkInfoImpl().isNotConnected) {
    return "You are currently offline";
  }
  try {
    final response = await http.head(Uri.parse(url));
    final contentType = response.headers["content-type"];
    if (contentType == null || !contentType.startsWith("image/")) {
      return "Link doesn't point to an image";
    }
    return null;
  } catch (error) {
    return "Link is Not valid";
  }
}

num getRangeRandom({
  required double from,
  required double to,
  RandomType randomType = RandomType.double,
}) {
  final doubleRandom = Random().nextDouble() * (to - from) + from;

  if (randomType == RandomType.double) {
    return doubleRandom;
  }

  return doubleRandom.toInt();
}

enum RandomType {
  int,
  double,
}
