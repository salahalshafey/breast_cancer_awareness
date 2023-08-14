import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import '../widgets/awareness/youtube_player.dart';
import 'home_screen.dart';

class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen(this.awarenessInfo, {super.key});

  final AwarenessInfo awarenessInfo;

  @override
  State<AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen> {
  var _isDeviceConnected = false;
  late StreamSubscription<bool> _connectivitySubscription;
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId:
        YoutubePlayer.convertUrlToId(widget.awarenessInfo.videoLink)!,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
    ),
  );

  @override
  void initState() {
    _connectivitySubscription = InternetConnectivity()
        .observeInternetConnection
        .listen((bool hasInternetAccess) {
      setState(() {
        _isDeviceConnected = hasInternetAccess;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
        children: [
          _isDeviceConnected
              ? YoutubPlayer(
                  videoLink: widget.awarenessInfo.videoLink,
                  controller: _controller,
                )
              : SizedBox(
                  height: 250,
                  child: Image.asset(widget.awarenessInfo.image),
                ),
          const SizedBox(height: 20),
          Text(
            widget.awarenessInfo.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            widget.awarenessInfo.description,
            textAlign: TextAlign.justify,
            textDirection: firstCharIsArabic(widget.awarenessInfo.description)
                ? TextDirection.rtl
                : TextDirection.ltr,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
