import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MirrorScreen extends StatefulWidget {
  const MirrorScreen({super.key, required this.fronCamera});

  final CameraDescription fronCamera;

  @override
  State<MirrorScreen> createState() => _MirrorScreenState();
}

class _MirrorScreenState extends State<MirrorScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.fronCamera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: Text("Error Happend."),
        ),
      );
    }
    return Scaffold(
      body: CameraPreview(controller),
    );
  }
}
