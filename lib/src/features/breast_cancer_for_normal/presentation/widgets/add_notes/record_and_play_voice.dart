import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/util/builders/custom_snack_bar.dart';
import '../../../../../core/util/functions/date_time_and_duration.dart';

import '../../providers/add_notes_state_provider.dart';
import '../audio_player.dart';

class RecordAndPlayVoice extends StatefulWidget {
  const RecordAndPlayVoice(this.addNoteState, {super.key});

  final AddNotesStateProvider addNoteState;

  @override
  State<RecordAndPlayVoice> createState() => _RecordAndPlayVoiceState();
}

class _RecordAndPlayVoiceState extends State<RecordAndPlayVoice> {
  final _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  late String? _recorderFilePath = widget.addNoteState.recordFilePath;
  final _toFilePath = "${DateTime.now().toString().hashCode}.aac";

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _initTheRecorder();

    super.initState();
  }

  Future<void> _initTheRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      // ignore: use_build_context_synchronously
      showCustomSnackBar(
        context: context,
        content: 'We need microphone permission to send the recorder.',
      );
      return;
    }

    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> _startTheRecorder() async {
    await _recorder.startRecorder(
      toFile: _toFilePath, // every open of bottomSheet has recorder unique path
    );

    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopTheRecorder() async {
    final path = await _recorder.stopRecorder();

    setState(() {
      _isRecording = false;
      _recorderFilePath = path;
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);

    _recorder.closeRecorder();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 10,
        left: 10,
        right: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: _recorder.onProgress,
            builder: (context, snapshot) {
              if (snapshot.hasData & _isRecording) {
                return RecordInfo(
                  duration: snapshot.data!.duration,
                  decibels: snapshot.data!.decibels ?? 0,
                );
              }

              return _recorderFilePath != null
                  ? AudioPlayer(recorderFilePath: _recorderFilePath!)
                  : const SizedBox(height: 55);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _recorderFilePath = null;
                  });
                },
                icon: const Icon(Icons.delete, size: 40),
              )
                  .animate(
                    target:
                        (_recorderFilePath != null && !_isRecording) ? 1 : 0,
                  )
                  .scaleXY(begin: 0, end: 1, duration: 250.ms)
                  .fade(begin: 0, end: 1),
              ElevatedButton(
                onPressed: () async {
                  _recorder.isRecording
                      ? await _stopTheRecorder()
                      : await _startTheRecorder();
                },
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(70, 70)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000))),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(8.0)),
                ),
                child: Icon(
                  _recorder.isRecording ? Icons.stop : Icons.mic,
                  size: 40,
                ),
              ),
              const SizedBox(width: 60),
            ],
          ),
          ActionsButtons(
            onSave: () async {
              if (_isRecording) {
                final path = await _recorder.stopRecorder();
                widget.addNoteState.setRecord(path);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                return;
              }

              widget.addNoteState.setRecord(_recorderFilePath);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
/////////////////////// widgets used upove /////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class RecordInfo extends StatelessWidget {
  const RecordInfo({super.key, required this.duration, required this.decibels});

  final Duration duration;
  final double decibels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatedDuration(duration),
            style: const TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Recording",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ).animate(
            onComplete: (controller) {
              controller.repeat(reverse: true);
            },
          ).fade(
            duration: 1.seconds,
            delay: 0.5.seconds,
            begin: 1,
            end: 0,
          ),
          const SizedBox(width: 50), // show decibels
        ],
      ),
    );
  }
}

/////////////////////////////////////////////
////////////////////////////////////////////

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({
    super.key,
    required this.onSave,
  });

  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: onSave,
          child: const Text(
            "SAVE  ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
