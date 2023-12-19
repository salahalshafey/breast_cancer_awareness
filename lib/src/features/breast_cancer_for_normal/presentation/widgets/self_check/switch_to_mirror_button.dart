// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/builders/custom_alret_dialog.dart';

import '../../pages/self_check_and_note_adding/mirror_screen.dart';

void _goToMirrorScreen(BuildContext context) async {
  try {
    final cameras = await availableCameras();
    final frontCamera = _getFrontCamera(cameras);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MirrorScreen(fronCamera: frontCamera),
      ),
    );
  } catch (error) {
    showCustomAlretDialog(
      context: context,
      title: AppLocalizations.of(context)!.error,
      titleColor: Colors.red,
      content: AppLocalizations.of(context)!.somethingWentWrong,
    );
  }
}

CameraDescription _getFrontCamera(List<CameraDescription> cameras) =>
    cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

List<Widget> switchToMirrorButton(BuildContext context) {
  return [
    Positioned(
      top: 30,
      left: 50,
      child: GestureDetector(
        onTap: () => _goToMirrorScreen(context),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(left: 30, right: 10, top: 10, bottom: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.switchToMirror,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color.fromRGBO(199, 40, 107, 1),
                ),
              ),

              // to make width of container equal with english letters
              const Text(
                "SWITCH TO MIRROR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    Positioned(
      top: 20,
      left: 5,
      child: GestureDetector(
        onTap: () => _goToMirrorScreen(context),
        child: const CircleAvatar(
          backgroundColor: Color.fromRGBO(199, 40, 107, 1),
          radius: 35,
        ),
      ),
    ),
    Positioned(
      top: 55,
      left: 10,
      child: GestureDetector(
        onTap: () => _goToMirrorScreen(context),
        child: const MirrorSimpol(widthAbove: 20, widthBelow: 40),
      ),
    ),
  ];
}

class MirrorSimpol extends StatelessWidget {
  const MirrorSimpol(
      {super.key, required this.widthAbove, required this.widthBelow});

  final double widthAbove;
  final double widthBelow;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationZ(-0.8),
      child: Column(
        children: [
          Container(
            height: 6,
            width: widthAbove,
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            width: widthBelow,
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}
