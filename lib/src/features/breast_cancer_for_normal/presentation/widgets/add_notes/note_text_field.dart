import 'package:breast_cancer_awareness/src/core/util/functions/string_manipulations_and_search.dart';
import 'package:flutter/material.dart';

import '../../providers/add_notes_state_provider.dart';

class NoteTextField extends StatefulWidget {
  const NoteTextField(this.addNoteState, {super.key});

  final AddNotesStateProvider addNoteState;

  @override
  State<NoteTextField> createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.addNoteState.text);

  late TextDirection _textDirection =
      firstCharIsRtl(widget.addNoteState.text ?? "")
          ? TextDirection.rtl
          : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: _controller,
            textDirection: _textDirection,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            autocorrect: false,
            minLines: 6,
            maxLines: 6,
            autofocus: true,
            style: const TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
              hintText: 'Enter a text',
              hintStyle: const TextStyle(),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black26,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              // filled: true,
              fillColor: Colors.transparent,
            ),
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              setState(() {
                _textDirection = firstCharIsRtl(value)
                    ? TextDirection.rtl
                    : TextDirection.ltr;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.addNoteState.setText(_controller.text);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          if (keyboardHeight != 0) const Spacer(),
        ],
      ),
    );
  }
}
