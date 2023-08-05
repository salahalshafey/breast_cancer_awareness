import 'dart:async';

import 'package:flutter/material.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

import 'youtube_player.dart';

class AwarenessVideoOrImage extends StatefulWidget {
  const AwarenessVideoOrImage(
      {super.key, required this.image, required this.videoLink});

  final String image;
  final String videoLink;

  @override
  State<AwarenessVideoOrImage> createState() => _AwarenessVideoOrImageState();
}

class _AwarenessVideoOrImageState extends State<AwarenessVideoOrImage> {
  var _isDeviceConnected = false;
  late StreamSubscription<bool> _connectivitySubscription;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isDeviceConnected
        ? YoutubPlayer(videoLink: widget.videoLink)
        : SizedBox(
            height: 250,
            child: Image.asset(widget.image),
          );
  }
}
