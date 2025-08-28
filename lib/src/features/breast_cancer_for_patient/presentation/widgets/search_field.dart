// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import 'speech_to_text.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.flutterTts,
    required this.setSearchWord,
  });

  final TextEditingController controller;
  final String hintText;
  final FlutterTts flutterTts;
  final void Function(String searchWord, {bool textToSpeech}) setSearchWord;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _focusNode = FocusNode();
  bool _hasFocus = false;

  late TextDirection _textDirection;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textDirection = getDirectionalityOf(widget.controller.text);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            key: const ValueKey('search'),
            focusNode: _focusNode,
            autocorrect: false,
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            textDirection: _textDirection,
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: _hasFocus ? Theme.of(context).primaryColor : null,
              prefixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        if (widget.controller.text.trim().isEmpty) {
                          return;
                        }

                        _focusNode.unfocus();

                        widget.setSearchWord(widget.controller.text.trim());
                      },
                      icon: const Icon(Icons.search),
                    )
                  : null,
              prefixIconColor: Colors.white,
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        widget.controller.clear();
                        _focusNode.requestFocus();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    )
                  : null,
              suffixIconColor: Colors.white,
            ),
            onTapOutside: (event) {
              _focusNode.unfocus();
            },
            style: const TextStyle(color: Colors.white, fontSize: 20),
            onChanged: (value) {
              setState(() {});
            },
            onSubmitted: (value) {
              if (widget.controller.text.trim().isEmpty) {
                _focusNode.requestFocus();
                return;
              }

              widget.setSearchWord(widget.controller.text.trim());
            },
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: () async {
            await widget.flutterTts.stop();

            final text = await showSpeechToTextDialog(context);

            if (text == null || text.isEmpty) {
              return;
            }

            widget.setSearchWord(text, textToSpeech: true);
          },
          tooltip: AppLocalizations.of(context)!.searchWithYourVoice,
          icon: const Icon(
            Icons.mic,
            size: 28,
            color: Colors.white,
          ),
          highlightColor: Colors.white.withValues(alpha: 0.2),
          style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).primaryColor),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
          ),
        ),
      ],
    );
  }
}
