// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/network/network_info.dart';
import '../../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../../../core/util/widgets/default_screen.dart';
import '../../../../account/presentation/widgets/icon_from_asset.dart';

import '../../../../../core/util/widgets/note_description.dart';
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
        title: AppLocalizations.of(context)!.error,
        titleColor: Colors.red,
        content: AppLocalizations.of(context)!.youAreCurrentlyOffline,
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
                  : Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(199, 40, 107, 0.2),
                        //.withOpacity(0.2),
                      ),
                      child: IconButton(
                        onPressed: _goToYoutubePlayerScreen,
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 60,
                          color: Color.fromRGBO(199, 40, 107, 1),
                        ),
                      ).animate(delay: 1500.ms).shake(duration: 1.seconds),
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
            title: AppLocalizations.of(context)!.description,
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
        ].animate(interval: 200.ms).fade().moveX(),
      ),
    );
  }
}
