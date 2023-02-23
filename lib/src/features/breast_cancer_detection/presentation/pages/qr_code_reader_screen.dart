import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeReaderScreen extends StatefulWidget {
  const QRCodeReaderScreen({super.key});

  @override
  State<QRCodeReaderScreen> createState() => _QRCodeReaderScreenState();
}

class _QRCodeReaderScreenState extends State<QRCodeReaderScreen> {
  final MobileScannerController cameraController = MobileScannerController(
      // detectionSpeed: DetectionSpeed.noDuplicates,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(child: Text('Mobile Scanner')),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: cameraController,
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          print(
              "<<<<<<<<<<<<<<<<<<<<<<<<<<<, Result >>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>>>>>");
          print(barcode.url?.url);
          print(barcode.rawValue);
          print(
              "<<<<<<<<<<<<<<<<<<<<<<<<<<<, Result >>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>>>>>");

          if (barcode.rawValue != null) {
            Navigator.of(context).pop(barcode.rawValue);
          }
          //
        },
      ),
    );
  }
}
