import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubPlayer extends StatelessWidget {
  const YoutubPlayer({
    super.key,
    required this.videoLink,
    required this.controller,
  });

  final String videoLink;
  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
    );
  }
}
