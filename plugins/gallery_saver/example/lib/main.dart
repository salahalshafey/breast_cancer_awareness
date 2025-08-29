import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

double textSize = 20;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String firstButtonText = 'Take photo';
  String secondButtonText = 'Record video';

  String albumName = 'Media';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: SizedBox.expand(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    onPressed: _takePhoto,
                    child: Text(firstButtonText,
                        style:
                            TextStyle(fontSize: textSize, color: Colors.white)),
                  ),
                ),
              ),
              const ScreenshotWidget(),
              Flexible(
                flex: 1,
                child: SizedBox.expand(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: _recordVideo,
                    child: Text(secondButtonText,
                        style: TextStyle(
                            fontSize: textSize, color: Colors.blueGrey)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _takePhoto() async {
    ImagePicker()
        .pickImage(source: ImageSource.camera)
        .then((XFile? recordedImage) {
      if (recordedImage != null) {
        setState(() {
          firstButtonText = 'saving in progress...';
        });
        GallerySaver.saveImage(recordedImage.path, albumName: albumName)
            .then((bool? success) {
          setState(() {
            firstButtonText = 'image saved!';
          });
        });
      }
    });
  }

  void _recordVideo() async {
    ImagePicker()
        .pickVideo(source: ImageSource.camera)
        .then((XFile? recordedVideo) {
      if (recordedVideo != null) {
        setState(() {
          secondButtonText = 'saving in progress...';
        });
        GallerySaver.saveVideo(recordedVideo.path, albumName: albumName)
            .then((bool? success) {
          setState(() {
            secondButtonText = 'video saved!';
          });
        });
      }
    });
  }

  // ignore: unused_element
  void _saveNetworkVideo() async {
    String path =
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4';
    GallerySaver.saveVideo(path, albumName: albumName).then((bool? success) {
      setState(() {
        print('Video is saved');
      });
    });
  }

  // ignore: unused_element
  void _saveNetworkImage() async {
    String path =
        'https://image.shutterstock.com/image-photo/montreal-canada-july-11-2019-600w-1450023539.jpg';
    GallerySaver.saveImage(path, albumName: albumName).then((bool? success) {
      setState(() {
        print('Image is saved');
      });
    });
  }
}

class ScreenshotWidget extends StatefulWidget {
  const ScreenshotWidget({Key? key}) : super(key: key);

  @override
  State<ScreenshotWidget> createState() => _ScreenshotWidgetState();
}

class _ScreenshotWidgetState extends State<ScreenshotWidget> {
  final GlobalKey _globalKey = GlobalKey();
  String screenshotButtonText = 'Save screenshot';

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: RepaintBoundary(
        key: _globalKey,
        child: SizedBox.expand(
          child: TextButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.pink),
            ),
            onPressed: _saveScreenshot,
            child: Text(screenshotButtonText,
                style: TextStyle(fontSize: textSize, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Future<void> _saveScreenshot() async {
    setState(() {
      screenshotButtonText = 'saving in progress...';
    });
    try {
      //extract bytes
      final RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      //create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String fullPath = '$dir/${DateTime.now().millisecond}.png';
      File capturedFile = File(fullPath);
      await capturedFile.writeAsBytes(pngBytes);
      print(capturedFile.path);

      await GallerySaver.saveImage(capturedFile.path).then((value) {
        setState(() {
          screenshotButtonText = 'screenshot saved!';
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
