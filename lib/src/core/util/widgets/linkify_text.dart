import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../classes/pair_class.dart';

class LinkifyText extends StatefulWidget {
  const LinkifyText({
    required this.text,
    required this.style,
    required this.textAlign,
    required this.textDirection,
    required this.linkStyle,
    required this.onOpen,
    Key? key,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextDirection textDirection;
  final TextStyle linkStyle;
  final void Function(String link, TextType linkType) onOpen;

  @override
  State<LinkifyText> createState() => _LinkifyTextState();
}

class _LinkifyTextState extends State<LinkifyText> {
  bool _isUrlEntered = false;
  bool _isEmailEntered = false;
  bool _isPhoneNumberEntered = false;

  void _settingUrlEnteredState(bool state) {
    setState(() {
      _isUrlEntered = state;
    });
  }

  void _settingEmailEnteredState(bool state) {
    setState(() {
      _isEmailEntered = state;
    });
  }

  void _settingPhoneNumberEnteredState(bool state) {
    setState(() {
      _isPhoneNumberEntered = state;
    });
  }

  TapGestureRecognizer _customTapGestureRecognizerOf(
      void Function(bool state) settingEnteredState) {
    return TapGestureRecognizer()
      ..onTapDown = (details) {
        settingEnteredState(true);
      }
      ..onTapCancel = () {
        settingEnteredState(false);
      }
      ..onTapUp = (_) {
        settingEnteredState(false);
      };
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: getLinksInText(widget.text).map((inlineText) {
          if (inlineText.second == TextType.url) {
            return TextSpan(
              recognizer: _customTapGestureRecognizerOf(_settingUrlEnteredState)
                ..onTap =
                    () => widget.onOpen(inlineText.first, inlineText.second),
              text: inlineText.first,
              style: widget.linkStyle.copyWith(
                backgroundColor: _isUrlEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
            );
          }

          if (inlineText.second == TextType.email) {
            return TextSpan(
              recognizer:
                  _customTapGestureRecognizerOf(_settingEmailEnteredState)
                    ..onTap = () =>
                        widget.onOpen(inlineText.first, inlineText.second),
              text: inlineText.first,
              style: widget.linkStyle.copyWith(
                backgroundColor: _isEmailEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
            );
          }

          if (inlineText.second == TextType.phoneNumber) {
            return TextSpan(
              recognizer:
                  _customTapGestureRecognizerOf(_settingPhoneNumberEnteredState)
                    ..onTap = () =>
                        widget.onOpen(inlineText.first, inlineText.second),
              text: inlineText.first,
              style: widget.linkStyle.copyWith(
                backgroundColor: _isPhoneNumberEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
            );
          }

          return TextSpan(
            text: inlineText.first,
            style: widget.style,
          );
        }).toList(),
      ),
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
    );
  }
}

class SelectableLinkifyText extends StatefulWidget {
  const SelectableLinkifyText({
    required this.text,
    required this.style,
    this.textAlign,
    required this.textDirection,
    required this.linkStyle,
    required this.onOpen,
    Key? key,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextDirection textDirection;
  final TextStyle linkStyle;
  final void Function(String link, TextType linkType) onOpen;

  @override
  State<SelectableLinkifyText> createState() => _SelectableLinkifyTextState();
}

class _SelectableLinkifyTextState extends State<SelectableLinkifyText> {
  bool _isUrlEntered = false;
  bool _isEmailEntered = false;
  bool _isPhoneNumberEntered = false;

  void _settingUrlEnteredState(bool state) {
    setState(() {
      _isUrlEntered = state;
    });
  }

  void _settingEmailEnteredState(bool state) {
    setState(() {
      _isEmailEntered = state;
    });
  }

  void _settingPhoneNumberEnteredState(bool state) {
    setState(() {
      _isPhoneNumberEntered = state;
    });
  }

  TapGestureRecognizer _customTapGestureRecognizerOf(
      void Function(bool state) settingEnteredState) {
    return TapGestureRecognizer()
      ..onTapDown = (details) {
        settingEnteredState(true);
      }
      ..onTapCancel = () {
        settingEnteredState(false);
      }
      ..onTapUp = (_) {
        settingEnteredState(false);
      };
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: getLinksInText(widget.text).map((inlineText) {
          if (inlineText.second == TextType.url) {
            return TextSpan(
              recognizer: _customTapGestureRecognizerOf(_settingUrlEnteredState)
                ..onTap =
                    () => widget.onOpen(inlineText.first, inlineText.second),
              text: inlineText.first,
              style: widget.linkStyle.copyWith(
                backgroundColor: _isUrlEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
            );
          }

          if (inlineText.second == TextType.email) {
            return TextSpan(
              recognizer:
                  _customTapGestureRecognizerOf(_settingEmailEnteredState)
                    ..onTap = () =>
                        widget.onOpen(inlineText.first, inlineText.second),
              text: inlineText.first,
              style: widget.linkStyle.copyWith(
                backgroundColor: _isEmailEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
            );
          }

          if (inlineText.second == TextType.phoneNumber) {
            return TextSpan(
              recognizer:
                  _customTapGestureRecognizerOf(_settingPhoneNumberEnteredState)
                    ..onTap = () =>
                        widget.onOpen(inlineText.first, inlineText.second),
              text: inlineText.first,
              style: widget.linkStyle.copyWith(
                backgroundColor: _isPhoneNumberEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
            );
          }

          return TextSpan(
            text: inlineText.first,
            style: widget.style,
          );
        }).toList(),
      ),
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
    );
  }
}

List<Pair<String, TextType>> getLinksInText(String text) {
  final urlMatcher = RegExp(
      r"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})");
  final emailMatcher =
      RegExp(r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}");
  final egyptPhoneNumberMatcher = RegExp(
      r"01[0125][0-9]{8}|(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}");

  List<Pair<Match, TextType>> allMatches = [];
  String myText = text;

  final urlMatches = urlMatcher
      .allMatches(myText)
      .map((urlMatch) => Pair(urlMatch, TextType.url));
  allMatches.addAll(urlMatches);
  myText = myText.replaceAllMapped(
      urlMatcher, (match) => ''.padLeft(match.end - match.start));

  final emailMatches = emailMatcher
      .allMatches(myText)
      .map((emailMatch) => Pair(emailMatch, TextType.email));
  allMatches.addAll(emailMatches);
  myText = myText.replaceAllMapped(
      emailMatcher, (match) => ''.padLeft(match.end - match.start));

  final phoneMatches = egyptPhoneNumberMatcher
      .allMatches(myText)
      .map((phoneMatch) => Pair(phoneMatch, TextType.phoneNumber));
  allMatches.addAll(phoneMatches);

  allMatches.sort((p1, p2) => p1.first.start.compareTo(p2.first.start));

  List<Pair<String, TextType>> links = [];
  int i = 0;
  for (final match in allMatches) {
    links.add(Pair(
      text.substring(i, match.first.start),
      TextType.normal,
    ));
    links.add(Pair(
      text.substring(match.first.start, match.first.end),
      match.second,
    ));
    i = match.first.end;
  }
  links.add(Pair(
    text.substring(i),
    TextType.normal,
  ));

  return links;
}

enum TextType {
  url,
  phoneNumber,
  email,
  normal,
}
