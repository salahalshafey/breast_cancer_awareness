import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/util/functions/string_manipulations_and_search.dart';

class AIResultNormalText extends StatelessWidget {
  const AIResultNormalText({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: patternMatcher(
          data,
          patterns: [
            // url
            RegExp(
              r"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})",
            ),

            // email
            RegExp(
              r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}",
            ),

            // bold
            RegExp(
              r"\*\*.*?\*\*",
              multiLine: true,
              dotAll: true,
            ),

            // highlighted
            RegExp(
              r"`.+?`",
              multiLine: true,
              dotAll: true,
            ),
          ],
          types: [
            StringTypes.url,
            StringTypes.email,
            StringTypes.bold,
            StringTypes.highlighted,
            StringTypes.normal,
          ],
        ).map((inlineText) {
          if (inlineText.type == StringTypes.url) {
            return TextSpan(
              text: inlineText.string,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  final link = inlineText.string;

                  if (link.startsWith('www.')) {
                    launchUrl(
                      Uri.parse('https:$link'),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    launchUrl(
                      Uri.parse(link),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
            );
          }

          if (inlineText.type == StringTypes.email) {
            return TextSpan(
              text: inlineText.string,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrl(Uri.parse('mailto:${inlineText.string}'));
                },
            );
          }

          if (inlineText.type == StringTypes.bold) {
            return TextSpan(
              text:
                  inlineText.string.substring(2, inlineText.string.length - 2),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            );
          }

          if (inlineText.type == StringTypes.highlighted) {
            return TextSpan(
              text: inlineText.string.replaceAll("`", "  "),
              style: TextStyle(backgroundColor: Colors.grey.withOpacity(0.3)),
            );
          }

          return TextSpan(text: inlineText.string);
        }).toList(),
      ),
      textDirection:
          firstCharIsArabic(data) ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}

enum StringTypes {
  url,
  email,
  bold,
  highlighted,
  normal,
}
