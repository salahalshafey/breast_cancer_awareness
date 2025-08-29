// // lib/features/doctor/inference/tflite_service.dart
// import 'dart:io';
// import 'dart:math' as math;
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

// class TFLiteService {
//   Interpreter? _interpreter;
//   late List<String> _labels;

//   bool get isInitialized => _interpreter != null;

//   Future<void> init({
//     required String modelPathOnDisk,
//     required String labelsPathOnDisk,
//     bool useGpu = false,
//   }) async {
//     // Load labels
//     _labels = await File(labelsPathOnDisk).readAsLines();

//     // Build options (try GPU, fall back to CPU)
//     final options = InterpreterOptions()..threads = 1;
//     if (useGpu) {
//       try {
//         options.addDelegate(GpuDelegateV2());
//       } catch (_) {
//         // Fallback silently to CPU if GPU delegate fails to init
//       }
//     }

//     // You got model.file.path from FirebaseModelDownloader, so use fromFile:
//     _interpreter = await Interpreter.fromFile(File(modelPathOnDisk), options: options);
//   }

//   void close() {
//     _interpreter?.close();
//     _interpreter = null;
//   }

//   /// Run inference on an image path.
//   /// Adjust normalization and size to match your model.
//   Future<Map<String, dynamic>> predictImage({
//     required String imagePath,
//     double mean = 0.0,
//     double std = 1.0,
//   }) async {
//     if (_interpreter == null) {
//       throw StateError('Interpreter not initialized. Call init() first.');
//     }

//     // Discover input tensor shape (e.g., [1, 224, 224, 3])
//     final inputTensor = _interpreter!.getInputTensor(0);
//     final inputShape = inputTensor.shape;
//     final height = inputShape[1];
//     final width  = inputShape[2];

//     // Pre-process using helper
//     TensorImage inputImage = TensorImage.fromFile(File(imagePath));
//     final processor = ImageProcessorBuilder()
//         .add(ResizeOp(height, width, ResizeMethod.bilinear))
//         .add(NormalizeOp(mean, std))
//         .build();
//     inputImage = processor.process(inputImage);

//     // Prepare input/output buffers
//     var inputBuffer = inputImage.buffer;
//     final outputTensor = _interpreter!.getOutputTensor(0);
//     final outputShape  = outputTensor.shape;         // e.g., [1, numClasses]
//     final outputType   = outputTensor.type;
//     final outputBuffer = TensorBuffer.createFixedSize(outputShape, outputType);

//     // Inference
//     _interpreter!.run(inputBuffer, outputBuffer.buffer);

//     // Post-process: top-1
//     final scores = outputBuffer.getDoubleList();     // length = numClasses
//     int topIdx = 0;
//     double topScore = -1;
//     for (int i = 0; i < scores.length; i++) {
//       if (scores[i] > topScore) {
//         topScore = scores[i];
//         topIdx = i;
//       }
//     }

//     final label = (topIdx >= 0 && topIdx < _labels.length) ? _labels[topIdx] : 'Unknown';
//     final confidence = topScore;

//     return {
//       'label': label,
//       'index': topIdx,
//       'confidence': confidence, // 0..1
//       'scores': scores,
//     };
//   }
// }
