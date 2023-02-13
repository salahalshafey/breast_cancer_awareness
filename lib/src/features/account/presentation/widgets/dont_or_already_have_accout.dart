import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontOrAlreadyHaveAccount extends StatefulWidget {
  const DontOrAlreadyHaveAccount({
    required this.text,
    required this.actionText,
    required this.onTap,
    super.key,
  });

  final String text;
  final String actionText;
  final void Function()? onTap;

  @override
  State<DontOrAlreadyHaveAccount> createState() =>
      _DontOrAlreadyHaveAccountState();
}

class _DontOrAlreadyHaveAccountState extends State<DontOrAlreadyHaveAccount> {
  bool _isEntered = false;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          color: Color.fromRGBO(143, 39, 83, 1),
          fontSize: 18,
        ),
        children: [
          TextSpan(text: widget.text),
          TextSpan(
            text: widget.actionText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              backgroundColor: _isEntered
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                  : null,
            ),
            // onEnter: (event) {},
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
              ..onTap = widget.onTap,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
