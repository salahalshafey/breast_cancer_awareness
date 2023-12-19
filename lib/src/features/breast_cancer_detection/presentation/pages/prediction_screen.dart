// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../../app.dart';
import '../../../../core/error/error_exceptions_with_message.dart';
import '../../../../core/util/widgets/image_container.dart';
import '../providers/for_doctor_screen_state_provider.dart';
import '../widgets/styled_text.dart';

class PredictionScreen extends StatefulWidget {
  static const routName = '/prediction-screen';
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context, listen: false);
    final isXray = ModalRoute.of(context)!.settings.arguments as bool;

    return Scaffold(
      body: FutureBuilder(
        future: _getPrediction(context, provider, isXray),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!
                            .itMayTakeAWhileTheModelIsGettingDownloaded,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black54
                                  : Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                snapshot.error == null
                    ? AppLocalizations.of(context)!.somethingWentWrong
                    : "${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          final screenSize = MediaQuery.of(context).size;
          final imageWidth = min(screenSize.width, screenSize.height) * 0.5;

          final imageType = isXray
              ? AppLocalizations.of(context)!.xrayImage
              : AppLocalizations.of(context)!.histologyImage;
          final prediction = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            children: [
              StyledText(
                  text: AppLocalizations.of(context)!.predictionOf(imageType)),
              const SizedBox(height: 40),
              ImageContainer(
                image: provider.fileImage != null
                    ? provider.fileImage!.path
                    : provider.networkImage!,
                imageSource:
                    provider.fileImage != null ? From.file : From.network,
                radius: imageWidth,
                borderRadius: BorderRadius.circular(10),
                fit: BoxFit.cover,
                showHighlight: true,
                showImageScreen: true,
                imageTitle:
                    AppLocalizations.of(context)!.predictionOf(imageType),
                imageCaption: prediction,
              ),
              const SizedBox(height: 20),
              Text(
                prediction,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<String> _getPrediction(
    BuildContext context, ForDoctorScreenState provider, bool isXray) async {
  String prediction = "";
  try {
    final model = await FirebaseModelDownloader.instance.getModel(
      isXray ? "xray_model_for_deployment" : "histo_model_for_deployment",
      FirebaseModelDownloadType.localModelUpdateInBackground,
      FirebaseModelDownloadConditions(
        iosAllowsCellularAccess: true,
        iosAllowsBackgroundDownloading: false,
        androidChargingRequired: false,
        androidWifiRequired: false,
        androidDeviceIdleRequired: false,
      ),
    );
    final labelsPath = await _saveLabelsToFile();

    Tflite.close();
    await Tflite.loadModel(
      model: model.file.path, // "assets/xray_model_for_deployment.tflite",
      labels: labelsPath, //"assets/labels.txt",
      numThreads: 1, // defaults to 1
      isAsset:
          false, // defaults to true, set to false to load resources outside assets
      useGpuDelegate:
          false, // defaults to false, set to true to use GPU delegate
    );

    final filepath = provider.fileImage != null
        ? provider.fileImage!.path
        : await _getNetworkImageToFile(provider.networkImage);

    final recognitions = await Tflite.runModelOnImage(
        path: filepath, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: isXray ? 255.0 : 1.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        ); // _getPredictionLabel(recognitions![0]["label"])

    prediction = AppLocalizations.of(context)!.predictionWithConfidence(
      _getPredictionLabel(recognitions![0]["label"]),
      _getConfidence(recognitions[0]["confidence"]),
    );
  } catch (error) {
    throw ErrorMessage(AppLocalizations.of(context)!.somethingWentWrong);
  }

  return prediction;
}

String _getPredictionLabel(String label) {
  final context = navigatorKey.currentContext!;

  switch (label) {
    case "Normal":
      return AppLocalizations.of(context)!.normalLabel;
    case "Cancer":
      return AppLocalizations.of(context)!.cancerLabel;
    default:
      return AppLocalizations.of(context)!.normalLabel;
  }
}

String _getConfidence(double confidence) {
  final context = navigatorKey.currentContext!;

  confidence *= 100;
  if (confidence < 90) {
    return confidence.toStringAsFixed(0);
  }

  return AppLocalizations.of(context)!.aboveNinety;
}

Future<String> _saveLabelsToFile() async {
  // Load the contents of labels.txt from assets
  String labelsContent = await rootBundle.loadString('assets/labels.txt');

  // Get the application documents directory
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  // Create the file path
  String filePath = '${documentsDirectory.path}/labels.txt';

  // Write the contents to the file
  File labelsFile = File(filePath);
  await labelsFile.writeAsString(labelsContent);

  return filePath;
}

Future<String> _getNetworkImageToFile(String? imageUrl) async {
  final context = navigatorKey.currentContext!;

  if (imageUrl == null) {
    throw ErrorMessage(
      AppLocalizations.of(context)!.youDidntProvideAnImage,
    );
  }

  final tempDir = await getTemporaryDirectory();
  String path = '${tempDir.path}/${imageUrl.hashCode}.jpeg';
  await Dio().download(imageUrl, path);

  return path;
}
