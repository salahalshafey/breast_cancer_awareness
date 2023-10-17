import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextWithActionText extends StatefulWidget {
  const TextWithActionText({
    required this.text,
    this.textStyle = const TextStyle(),
    required this.actionText,
    this.actionTextStyle = const TextStyle(),
    required this.onActionTextTap,
    super.key,
  });

  final String text;
  final TextStyle textStyle;
  final String actionText;
  final TextStyle actionTextStyle;
  final void Function() onActionTextTap;

  @override
  State<TextWithActionText> createState() => _TextWithActionTextState();
}

class _TextWithActionTextState extends State<TextWithActionText> {
  bool _isEntered = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: widget.text,
              style: widget.textStyle,
            ),
            TextSpan(
              text: widget.actionText,
              style: widget.actionTextStyle.copyWith(
                backgroundColor: _isEntered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                    : null,
              ),
              recognizer: TapGestureRecognizer()
                ..onTapDown = (details) {
                  setState(() {
                    _isEntered = true;
                  });
                }
                ..onTapCancel = () {
                  setState(() {
                    _isEntered = false;
                  });
                }
                ..onTapUp = (_) {
                  setState(() {
                    _isEntered = false;
                  });
                }
                ..onTap = widget.onActionTextTap,
            ),
          ],
        ),
      ),
    );
  }
}
