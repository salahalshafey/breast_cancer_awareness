import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dotted_border/dotted_border.dart';

import '../widgets/box_content.dart';
import '../widgets/image.dart';
import '../widgets/add_and_show_result_button.dart';

import '../providers/for_doctor_screen_state_provider.dart';

class ForDoctorsScreen extends StatelessWidget {
  const ForDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final shapeHeight = screenSize.width * (isportrait ? 0.30 : 0.13);

    final provider = Provider.of<ForDoctorScreenState>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: shapeHeight),
        children: [
          const SizedBox(height: 10),
          const Text(
            "Pick a Medical Image of Breast Cancer Radiology of The Patient.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "See The Result OR Prediction Using The Machine Learning Model.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Align(
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              padding: EdgeInsets.zero,
              color: const Color.fromRGBO(112, 112, 112, 0.40),
              dashPattern: const [7, 7],
              child: Container(
                width: screenSize.width,
                height: screenSize.width * 0.65,
                constraints: const BoxConstraints(
                  maxWidth: 450,
                  maxHeight: 450 * 0.5,
                ),
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(112, 112, 112, 0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: provider.fileImage != null
                    ? ImageFromFile(imagePath: provider.fileImage!.path)
                    : provider.networkImage != null
                        ? ImageFromNetwork(imageUrl: provider.networkImage!)
                        : const BoxContent(),
              ),
            ),
          )
              .animate(target: provider.isBoxShown ? 1 : 0)
              // .move(begin: Offset(-100, -100), end: Offset(0, 0))
              .scaleXY(begin: 0, end: 1, duration: 250.ms)
              .fade(begin: 0, end: 1),
          const SizedBox(height: 20),
          const AddAndShowResultButton(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
