// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/util/builders/custom_snack_bar.dart';

Future<String?> showSpeechToTextDialog(BuildContext context) async {
  final status = await Permission.microphone.request();

  if (status != PermissionStatus.granted) {
    showCustomSnackBar(
      context: context,
      content: 'Microphone permission is needed for speech recognition.',
    );

    return null;
  }

  Wakelock.enable();

  final text = await showDialog<String>(
    context: context,
    builder: (ctx) {
      return const Dialog(
        child: SizedBox(
          height: 270,
          width: 200,
          child: SpeechToTextWidget(),
        ),
      );
    },
  );

  await Wakelock.disable();

  return text;
}

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget({super.key});

  @override
  State<SpeechToTextWidget> createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget>
    with SingleTickerProviderStateMixin {
  final _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _speechStoped = true;
  String _text = "";

  @override
  void initState() {
    super.initState();

    _initSpeech();
    Future.delayed(50.ms, () {
      _startListening();
    });
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenMode: ListenMode.search,
      pauseFor: 5.seconds,
    );

    setState(() {
      _speechStoped = false;
    });

    Future.delayed(5.seconds, () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _stopListening() async {
    await _speechToText.stop();

    setState(() {
      _speechStoped = true;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _text = result.recognizedWords;
    });

    if (result.finalResult) {
      Navigator.of(context).pop(_text);
    }
  }

  @override
  void dispose() {
    _speechToText.cancel();
    super.dispose();
  }

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
              child: Text(
                _speechStoped
                    ? "Microphone off. Try again."
                    : _speechToText.isNotListening && _text.isEmpty
                        ? "Didn't hear that. Try again."
                        : _text.isEmpty
                            ? "Listening..."
                            : _text,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_speechToText.isListening)
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                      .animate(
                        onPlay: (controller) {
                          controller.repeat(period: 1.5.seconds);
                        },
                      )
                      .scaleXY(
                        begin: 0,
                        end: 2.2,
                        curve: Curves.easeOutCubic,
                      )
                      .fadeOut(
                        curve: Curves.easeInOutCubic,
                      ),
                Align(
                  child: ElevatedButton(
                    onPressed: () {
                      _speechToText.isNotListening
                          ? _startListening()
                          : _stopListening();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        _speechToText.isListening ? null : Colors.grey,
                      ),
                      fixedSize: const MaterialStatePropertyAll(Size(70, 70)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000))),
                      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                    child: const Icon(Icons.mic, size: 45),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              child: _speechToText.isListening
                  ? const SizedBox()
                  : Text(
                      _speechEnabled
                          ? "Tap the microphone to try again"
                          : "Speech not available",
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
