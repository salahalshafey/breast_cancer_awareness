import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/string_manipulations_and_search.dart';
import 'bulleted_list.dart';

class TextWellFormattedWithBulleted extends StatelessWidget {
  const TextWellFormattedWithBulleted({
    super.key,
    required this.data,
    this.isSelectableText = false,
  });

  final String data;
  final bool isSelectableText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: patternMatcher(
        data,
        patterns: [
          // bulleted
          RegExp(
            r"^\* .*",
            multiLine: true,
            dotAll: false,
          ),
        ],
        types: [
          StringTypes.bulleted,
          StringTypes.normal,
        ],
      ).map((inlineString) {
        if (inlineString.type == StringTypes.bulleted) {
          return BulletedList(
            textDirection:
                firstCharIsArabic(data) ? TextDirection.rtl : TextDirection.ltr,
            text: TextWellFormattedWitouthBulleted(
              data: inlineString.string.substring(2),
              isSelectableText: isSelectableText,
            ),
          );
        }

        return TextWellFormattedWitouthBulleted(
          data: inlineString.string,
          isSelectableText: isSelectableText,
        );
      }).toList(),
    );
  }
}

class TextWellFormattedWitouthBulleted extends StatefulWidget {
  const TextWellFormattedWitouthBulleted({
    super.key,
    required this.data,
    this.isSelectableText = false,
  });

  final String data;
  final bool isSelectableText;

  @override
  State<TextWellFormattedWitouthBulleted> createState() =>
      _TextWellFormattedWitouthBulletedState();
}

class _TextWellFormattedWitouthBulletedState
    extends State<TextWellFormattedWitouthBulleted> {
  int? _enteredSpanIndex;

  TapGestureRecognizer _customTapGestureRecognizerOf(int enteredSpanIndex) {
    return TapGestureRecognizer()
      ..onTapDown = (details) {
        setState(() {
          _enteredSpanIndex = enteredSpanIndex;
        });
      }
      ..onTapCancel = () {
        setState(() {
          _enteredSpanIndex = null;
        });
      }
      ..onTapUp = (_) {
        setState(() {
          _enteredSpanIndex = null;
        });
      };
  }

  TextSpan _getTextSpan(BuildContext context) {
    int i = 0;

    return TextSpan(
      children: patternMatcher(
        widget.data,
        patterns: [
          // url
          RegExp(
            r"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})",
          ),

          // email
          RegExp(
            r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}",
          ),

          // bold
          RegExp(
            r"\*\*.*?\*\*",
            multiLine: true,
            dotAll: true,
          ),

          // phone number (Egypt or global)
          RegExp(
            r"01[0125][0-9]{8}|(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$",
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
          StringTypes.phoneNumber,
          StringTypes.highlighted,
          StringTypes.normal,
        ],
      ).map((inlineText) {
        final currentSpanIndex = i++;

        if (inlineText.type == StringTypes.url) {
          return TextSpan(
            text: inlineText.string,
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue,
              backgroundColor: _enteredSpanIndex == currentSpanIndex
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                  : null,
              // decoration: TextDecoration.underline,
              //  decorationColor: Colors.blue,
            ),
            recognizer: _customTapGestureRecognizerOf(currentSpanIndex)
              ..onTap = () {
                final link = inlineText.string;

                launchUrl(
                  Uri.parse(link.startsWith('www.') ? 'https:$link' : link),
                  mode: LaunchMode.externalApplication,
                );
              },
          );
        }

        if (inlineText.type == StringTypes.email) {
          return TextSpan(
            text: inlineText.string,
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue,
              backgroundColor: _enteredSpanIndex == currentSpanIndex
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                  : null,
              // decoration: TextDecoration.underline,
              // decorationColor: Colors.blue,
            ),
            recognizer: _customTapGestureRecognizerOf(currentSpanIndex)
              ..onTap = () {
                launchUrl(Uri.parse('mailto:${inlineText.string}'));
              },
          );
        }

        if (inlineText.type == StringTypes.bold) {
          return TextSpan(
            text: inlineText.string.substring(2, inlineText.string.length - 2),
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          );
        }

        if (inlineText.type == StringTypes.phoneNumber) {
          return TextSpan(
            text: inlineText.string,
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue,
              backgroundColor: _enteredSpanIndex == currentSpanIndex
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                  : null,
            ),
            recognizer: _customTapGestureRecognizerOf(currentSpanIndex)
              ..onTap = () {
                launchUrl(Uri.parse('tel:${inlineText.string}'));
              },
          );
        }

        if (inlineText.type == StringTypes.highlighted) {
          return TextSpan(
            text: inlineText.string.replaceAll("`", " "),
            style: TextStyle(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.withOpacity(0.3)
                  : Colors.black,
            ),
          );
        }

        return TextSpan(text: inlineText.string);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSelectableText
        ? SelectableText.rich(
            _getTextSpan(context),
            textDirection: firstCharIsArabic(widget.data)
                ? TextDirection.rtl
                : TextDirection.ltr,
          )
        : Text.rich(
            _getTextSpan(context),
            textDirection: firstCharIsArabic(widget.data)
                ? TextDirection.rtl
                : TextDirection.ltr,
          );
  }
}

enum StringTypes {
  bulleted,
  url,
  email,
  bold,
  phoneNumber,
  highlighted,
  normal,
}
