// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../core/util/functions/string_manipulations_and_search.dart';

import 'speech_to_text.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
    this.hintText = "Search",
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
  Color? _focusColor;
  late TextDirection _textDirection = firstCharIsArabic(widget.controller.text)
      ? TextDirection.rtl
      : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            textDirection: _textDirection,
            onTap: () {
              setState(() {
                _focusColor = Theme.of(context).primaryColor;
              });
            },
            onTapOutside: (event) {
              _focusNode.unfocus();
              setState(() {
                _focusColor = null;
              });
            },
            style: const TextStyle(color: Colors.white, fontSize: 20),
            onChanged: (value) {
              setState(() {
                _textDirection = firstCharIsArabic(value)
                    ? TextDirection.rtl
                    : TextDirection.ltr;
              });
            },
            onSubmitted: (value) {
              setState(() {
                _focusColor = null;
              });

              if (widget.controller.text.trim().isEmpty) {
                return;
              }
              widget.setSearchWord(widget.controller.text.trim());
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: _focusColor,
              prefixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _focusNode.unfocus();
                        setState(() {
                          _focusColor = null;
                        });
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
                        setState(() {
                          _focusColor = Theme.of(context).primaryColor;
                        });
                      },
                      icon: const Icon(Icons.close),
                    )
                  : null,
              suffixIconColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          child: IconButton(
            onPressed: () async {
              await widget.flutterTts.stop();

              final text = await showSpeechToTextDialog(context);

              if (text == null || text.isEmpty) {
                return;
              }

              widget.setSearchWord(text, textToSpeech: true);
            },
            highlightColor: Colors.white.withOpacity(0.2),
            icon: const Icon(
              Icons.mic,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
