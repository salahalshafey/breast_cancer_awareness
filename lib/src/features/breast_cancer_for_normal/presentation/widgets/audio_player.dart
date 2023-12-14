import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/util/functions/date_time_and_duration.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    super.key,
    required this.recorderFilePath,
    this.audioPlayerController,
  });

  final String recorderFilePath;

  /// to set speed of the audio only (from outside this widget)
  final FlutterSoundPlayer? audioPlayerController;

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  late final FlutterSoundPlayer _audioPlayer =
      widget.audioPlayerController ?? FlutterSoundPlayer();

  late StreamSubscription<PlaybackDisposition> _playerStateSubscription;

  bool _isStarted = false;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  // _audioPlayer.setSpeed(0.5);/////.///

  @override
  void initState() {
    _initTheAudioPlayer();

    super.initState();
  }

  Future<void> _initTheAudioPlayer() async {
    await _audioPlayer.openPlayer();
    await _audioPlayer
        .setSubscriptionDuration(const Duration(milliseconds: 50));

    _playerStateSubscription = _audioPlayer.onProgress!.listen((event) {
      setState(() {
        _duration = event.duration;
        _position = event.position;
      });
    });

    final duration = await _audioPlayer.startPlayer(
      fromURI: widget.recorderFilePath,
      whenFinished: () {
        _audioPlayer.stopPlayer();
        setState(() {
          _isStarted = false;
          _isPlaying = false;
          _position = Duration.zero;
        });
      },
    );

    await _audioPlayer.pausePlayer();

    setState(() {
      _isStarted = true;
      _duration = duration ?? Duration.zero;
    });
  }

  Future<void> _startAudio() async {
    await _audioPlayer.startPlayer(
      fromURI: widget.recorderFilePath,
      whenFinished: () {
        _audioPlayer.stopPlayer();
        setState(() {
          _isStarted = false;
          _isPlaying = false;
          _position = Duration.zero;
        });
      },
    );

    setState(() {
      _isStarted = true;
      _isPlaying = true;
    });
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pausePlayer();

    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _resumeAudio() async {
    await _audioPlayer.resumePlayer();

    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _toggoleAudioPlaying() async {
    if (_isStarted && _isPlaying) {
      await _pauseAudio();
    } else if (_isStarted && !_isPlaying) {
      await _resumeAudio();
    } else {
      await _startAudio();
    }
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _audioPlayer.closePlayer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(end: 10),
      decoration: BoxDecoration(
        color: MyColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _toggoleAudioPlaying,
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              size: 40,
            ),
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: _duration.inMilliseconds.toDouble(),
              value: _position.inMilliseconds.toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(milliseconds: value.toInt());

                await _audioPlayer.seekToPlayer(newPosition);

                setState(() {
                  _position = newPosition;
                });
              },
            ),
          ),
          Text(
            formatedDuration(
              _position == Duration.zero ? _duration : _position,
            ),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    ).animate().scale();
  }
}
