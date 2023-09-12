import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.setSearchWord,
  });
  final TextEditingController controller;
  final void Function(String searchWord) setSearchWord;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _focusNode = FocusNode();
  Color? _focusColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
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
              setState(() {});
            },
            onSubmitted: (value) {
              setState(() {
                _focusColor = null;
              });

              if (widget.controller.text.isEmpty) {
                return;
              }
              widget.setSearchWord(widget.controller.text);
            },
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: _focusColor,
              prefixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _focusNode.unfocus();
                        setState(() {
                          _focusColor = null;
                        });
                        widget.setSearchWord(widget.controller.text);
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
            onPressed: () {
              widget.setSearchWord("frod");
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
