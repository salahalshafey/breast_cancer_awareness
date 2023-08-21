// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../../core/network/network_info.dart';
import '../../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../../core/util/widgets/default_screen.dart';
import '../../../../account/presentation/widgets/icon_from_asset.dart';

import '../../widgets/breast_check_history/note_description.dart';
import '../home_screen.dart';
import 'youtube_player_screen.dart';

class AwarenessScreen extends StatefulWidget {
  const AwarenessScreen(this.awarenessInfo, {super.key});

  final AwarenessInfo awarenessInfo;

  @override
  State<AwarenessScreen> createState() => _AwarenessScreenState();
}

class _AwarenessScreenState extends State<AwarenessScreen> {
  bool _isLoading = false;
  void _loadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _goToYoutubePlayerScreen() async {
    _loadingState(true);

    if (await NetworkInfoImpl().isNotConnected) {
      _loadingState(false);
      showCustomAlretDialog(
        context: context,
        title: "Error",
        titleColor: Colors.red,
        content: "You are currently offline.",
      );
      return;
    }

    _loadingState(false);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return YoutubePlayerScreen(
          widget.awarenessInfo.videoLink,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      child: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 80,
        ),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(widget.awarenessInfo.image, height: 250),
              _isLoading
                  ? const CircularProgressIndicator()
                  : IconButton(
                      onPressed: _goToYoutubePlayerScreen,
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 70,
                        color: Color.fromRGBO(199, 40, 107, 1),
                      ),
                    ),
            ],
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
          NoteDescription(
            icon: const Icon(Icons.info, size: 40),
            title: "Description",
            description: widget.awarenessInfo.description,
            descriptionStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 30),
          const IconFromAsset(
            assetIcon: "assets/images/background_cancer_sympol.png",
            iconHeight: 150,
            opacity: 0.62,
          )
        ],
      ),
    );
  }
}
