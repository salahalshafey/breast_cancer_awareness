import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceItem extends StatefulWidget {
  const ResourceItem({
    required this.text,
    required this.actionText,
    required this.url,
    super.key,
  });

  final String text;
  final String actionText;
  final String url;

  @override
  State<ResourceItem> createState() => _ResourceItemState();
}

class _ResourceItemState extends State<ResourceItem> {
  bool _isEntered = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: widget.text,
              style: const TextStyle(fontSize: 16),
            ),
            TextSpan(
              text: widget.actionText,
              style: TextStyle(
                color: const Color.fromRGBO(199, 40, 107, 1),
                fontSize: 17,
                fontWeight: FontWeight.bold,
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
                ..onTap = () {
                  launchUrl(
                    Uri.parse(widget.url),
                    mode: LaunchMode.externalApplication,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
