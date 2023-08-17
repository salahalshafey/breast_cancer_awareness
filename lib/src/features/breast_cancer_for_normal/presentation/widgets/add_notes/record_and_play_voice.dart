import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/theme/colors.dart';
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
  bool _isStarted = false;
  DateTime _lastRecordingTime = DateTime.now();
  Duration _lastRecordingDuration = Duration.zero;
  Icon _micOrPauseIcon = const Icon(Icons.mic, size: 40, key: ValueKey(1));

  late String? _recorderFilePath = widget.addNoteState.recordFilePath;
  final _toFilePath = "${DateTime.now().toString().hashCode}.aac";

  final List<double> _decibelsProgress = [];
  List<double> _getCurrentdecibelsProgress(double decibels) {
    if (_decibelsProgress.length < 70) {
      _decibelsProgress.add(decibels);
    } else {
      _decibelsProgress.removeAt(0);
      _decibelsProgress.add(decibels);
    }

    return _decibelsProgress;
  }

  @override
  void initState() {
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
      // Navigator.of(context).pop();
      return;
    }

    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 20));
  }

  Future<void> _startTheRecorder() async {
    await _recorder.startRecorder(
      toFile: _toFilePath, // every open of bottomSheet has recorder unique path
    );

    setState(() {
      _isRecording = true;
      _isStarted = true;
      _lastRecordingTime = DateTime.now();
    });
  }

  // ignore: unused_element
  Future<void> _stopTheRecorder() async {
    final path = await _recorder.stopRecorder();

    setState(() {
      _isRecording = false;
      _isStarted = false;
      _lastRecordingDuration = Duration.zero;
      _recorderFilePath = path;
    });
  }

  Future<void> _resumeRecorder() async {
    await _recorder.resumeRecorder();

    setState(() {
      _isRecording = true;
      _lastRecordingTime = DateTime.now();
    });
  }

  Future<void> _pauseRecorder() async {
    await _recorder.pauseRecorder();
    final path = await _recorder.getRecordURL(path: _toFilePath);

    setState(() {
      _isRecording = false;
      _recorderFilePath = path;
      _lastRecordingDuration += DateTime.now().difference(_lastRecordingTime);
    });
  }

  Future<void> _toggoleAudioRecording() async {
    if (_isStarted && _isRecording) {
      await _pauseRecorder();
    } else if (_isStarted && !_isRecording) {
      await _resumeRecorder();
    } else {
      await _startTheRecorder();
    }

    setState(() {
      _micOrPauseIcon = _isRecording
          ? const Icon(Icons.pause, size: 40, key: ValueKey(2))
          : const Icon(Icons.mic, size: 40, key: ValueKey(1));
    });
  }

  Future<void> _deleteRecording() async {
    await _recorder.stopRecorder();

    setState(() {
      _isRecording = false;
      _isStarted = false;
      _lastRecordingDuration = Duration.zero;
      _recorderFilePath = null;
    });
  }

  @override
  void dispose() {
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
          // recording state or audio player
          StreamBuilder(
            stream: _recorder.onProgress,
            builder: (context, snapshot) {
              if (snapshot.hasData & _isRecording) {
                final currentDuration =
                    DateTime.now().difference(_lastRecordingTime) +
                        _lastRecordingDuration;

                final decibelsProgress =
                    _getCurrentdecibelsProgress(snapshot.data!.decibels ?? 0);

                return RecordInfo(
                  duration: currentDuration,
                  decibelsProgress: decibelsProgress,
                );
              }

              return _recorderFilePath != null
                  ? AudioPlayer(recorderFilePath: _recorderFilePath!)
                  : const SizedBox(height: 55);
            },
          ),

          // recorder | pause button and delete recorder button and save button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _deleteRecording,
                icon: const Icon(Icons.delete, size: 40),
              )
                  .animate(
                    target:
                        (_recorderFilePath != null && !_isRecording) ? 1 : 0,
                  )
                  .scaleXY(begin: 0, end: 1, duration: 250.ms)
                  .fade(begin: 0, end: 1),
              ElevatedButton(
                onPressed: _toggoleAudioRecording,
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(70, 70)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000))),
                  padding: const MaterialStatePropertyAll(EdgeInsets.all(8.0)),
                ),
                child: AnimatedSwitcher(
                  duration: 300.ms,
                  child: _micOrPauseIcon,
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
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
                icon: const Icon(Icons.check, size: 40),
              )
                  .animate(
                    target: (widget.addNoteState.recordFilePath !=
                            _recorderFilePath)
                        ? 1
                        : 0,
                  )
                  .scaleXY(begin: 0, end: 1, duration: 250.ms)
                  .fade(begin: 0, end: 1),
            ],
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
  const RecordInfo(
      {super.key, required this.duration, required this.decibelsProgress});

  final Duration duration;
  final List<double> decibelsProgress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              formatedDuration(duration),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  color: MyColors.primaryColor,
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
          AudioWaveProgress(decibelsProgress: decibelsProgress),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////
////////////////////////////////////////////

class AudioWaveProgress extends StatelessWidget {
  const AudioWaveProgress({super.key, required this.decibelsProgress});

  final List<double> decibelsProgress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 70,
      child: Row(
        textDirection: TextDirection.ltr, // define the direction of the wave
        mainAxisSize: MainAxisSize.min,
        children: decibelsProgress
            .map((decibels) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0.1),
                  width: 0.8,
                  height: decibels < 0 ? 0 : decibels / 2,
                  color: MyColors.primaryColor,
                ))
            .toList(),
      ),
    );
  }
}
