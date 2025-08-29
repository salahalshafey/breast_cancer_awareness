// read_link_by_qr_code.dart
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

Future<String?> scanQrAndGetText(BuildContext context) async {
  return Navigator.push<String?>(
    context,
    MaterialPageRoute(builder: (_) => const _QrScanPage()),
  );
}

class _QrScanPage extends StatefulWidget {
  const _QrScanPage();
  @override
  State<_QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<_QrScanPage> {
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _handled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.flash_on),
          onPressed: () => controller.toggleTorch(),
        ),
        IconButton(
          icon: const Icon(Icons.cameraswitch),
          onPressed: () => controller.switchCamera(),
        ),
      ]),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          if (_handled) return;
          final barcode = capture.barcodes.firstOrNull;
          final raw = barcode?.rawValue;
          if (raw != null && raw.isNotEmpty) {
            _handled = true;
            Navigator.pop(context, raw);
          }
        },
      ),
    );
  }
}
