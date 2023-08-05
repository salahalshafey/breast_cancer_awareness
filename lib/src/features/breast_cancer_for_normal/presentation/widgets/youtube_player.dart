import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubPlayer extends StatefulWidget {
  const YoutubPlayer({super.key, required this.videoLink});
  final String videoLink;

  @override
  State<YoutubPlayer> createState() => _YoutubPlayerState();
}

class _YoutubPlayerState extends State<YoutubPlayer> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink)!,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();

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
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
    );
  }
}
