import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wakelock/wakelock.dart';

Future<String?> showSpeechToTextDialog(BuildContext context) async {
  Wakelock.enable();

  final text = await showDialog<String>(
    context: context,
    builder: (context) {
      return const Dialog(
        child: SizedBox(
          height: 270,
          width: 200,
          child: SpeechToTextWidget(),
        ),
      );
    },
  );

  Wakelock.disable();

  return text;
}

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget({super.key});

  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  String _text = "Listening...";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              // reverse: true,
              child: Text(_text),
            ),
          ),
          Expanded(
            flex: 6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Animate(
                  delay: 200.ms,
                  onPlay: (controller) {
                    controller.repeat();
                  },
                )
                    .custom(
                      begin: 80,
                      end: 150,
                      duration: 1.5.seconds,
                      curve: Curves.decelerate,
                      builder: (context, value, child) {
                        return Container(
                          height: value,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                        );
                      },
                    )
                    .fadeOut(
                      duration: 1.5.seconds,
                      curve: Curves.decelerate,
                    ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_text);
                  },
                  style: ButtonStyle(
                    fixedSize: const MaterialStatePropertyAll(Size(80, 80)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000))),
                    padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                  child: const Icon(Icons.mic, size: 35),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Align(
              child: SizedBox(), // Text("Tap the microphone to try again"),
            ),
          ),
        ],
      ),
    );
  }
}
