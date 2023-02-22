import 'dart:io';
import 'dart:math';

import 'package:breast_cancer_awareness/src/core/theme/colors.dart';
import 'package:breast_cancer_awareness/src/core/util/builders/image_picker.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/custom_card.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/image_container.dart';
import 'package:breast_cancer_awareness/src/features/account/presentation/widgets/dont_or_already_have_accout.dart';
import 'package:breast_cancer_awareness/src/features/breast_cancer_detection/presentation/providers/for_doctor_screen_state_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../settings/widgets/set_theme_mode.dart';

class ForDoctorsScreen extends StatelessWidget {
  const ForDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final shapeHeight = screenSize.width * (isportrait ? 0.30 : 0.13);

    final provider = Provider.of<ForDoctorScreenState>(context);
    print(screenSize);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: shapeHeight,
        ),
        children: [
          const SizedBox(height: 50),
          const SetThemeMode(),
          const SizedBox(height: 10),
          const Text(
            "Pick a Medical Image of Breast Cancer Radiology of The Patient.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "See The Result OR Prediction Using The Machine Learning Model.",
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          Align(
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              padding: EdgeInsets.zero,
              color: const Color.fromRGBO(112, 112, 112, 0.40),
              dashPattern: const [7, 7],
              child: Container(
                width: screenSize.width,
                height: (screenSize.width) * 0.6,
                constraints: const BoxConstraints(
                  maxWidth: 450,
                  maxHeight: 450 * 0.6,
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
          const AddButton(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class BoxContent extends StatelessWidget {
  const BoxContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image == null) {
                    return;
                  }
                  provider.setFileImage(File(image.path));
                },
                child: Text(
                  "Open Camera",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
              ),
              const Text(
                " Or ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              TextButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) {
                    return;
                  }
                  provider.setFileImage(File(image.path));
                },
                child: Text(
                  "Pick an Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                //style: ButtonStyle(textStyle: ),
              ),
            ],
          ),
          const Spacer(flex: 2),
          Row(
            children: [
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Or",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Divider(
                  thickness: 1,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              // read QR Code
              // check if link is valid image (find a way without download)
              // if not valid show error (alret dialog), then return
              // if valid: provider.setNetworkImage("imageUrl");
              provider.setNetworkImage(
                  "https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/332570606_751710779508283_2202045999649125646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=730e14&_nc_ohc=w6f0UgitvrkAX8PgrL5&_nc_ht=scontent-hbe1-1.xx&oh=00_AfDQAN4_X8Y2mtt-6m-_L5kCYv3a5Dw0GYHHZ6N5bum6bQ&oe=63FAF9C8");
            },
            child: Text(
              "Get Image Link By QR Code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
              ),
            ),
            //style: ButtonStyle(textStyle: ),
          ),
          const Text("Form Field for Link will be here")
        ],
      ),
    );
  }
}

class ImageFromNetwork extends StatelessWidget {
  const ImageFromNetwork({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<ForDoctorScreenState>(context);

    return Stack(
      children: [
        ImageContainer(
          image: imageUrl,
          imageSource: From.network,
          radius: screenSize.width * 0.5,
          borderRadius: BorderRadius.circular(10),
          fit: BoxFit.cover,
          showHighlight: true,
          showImageScreen: true,
          showLoadingIndicator: true,
          showLoadingProgress: true,
        ),
        Positioned(
          top: -10,
          right: -10,
          child: IconButton(
            tooltip: "remove this image",
            onPressed: provider.resetBox,
            icon: const Icon(
              Icons.close,
              size: 30,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageFromFile extends StatelessWidget {
  const ImageFromFile({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<ForDoctorScreenState>(context);

    return Stack(
      children: [
        ImageContainer(
          image: imagePath,
          imageSource: From.file,
          radius: screenSize.width * 0.5,
          borderRadius: BorderRadius.circular(10),
          fit: BoxFit.cover,
          showHighlight: true,
          showImageScreen: true,
        ).animate().fadeIn(duration: 1.seconds),
        Positioned(
          top: -10,
          right: -10,
          child: IconButton(
            tooltip: "remove this image",
            onPressed: provider.resetBox,
            icon: const Icon(
              Icons.close,
              size: 30,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context);

    return Align(
        child: Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff0079ff).withOpacity(1),
            const Color(0xff313bbd).withOpacity(1),
            const Color(0xff521191).withOpacity(1),
            const Color(0xff4d1798).withOpacity(1),
            const Color(0xff5f0080).withOpacity(1)
          ],
          stops: const [0, 0.5, 0.862, 0.897, 1],
        ),
      ),
      child: IconButton(
        tooltip:
            provider.isBoxShown ? "hide image box above" : "show image box",
        onPressed: provider.togoleBoxShown,
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.add,
          size: 70,
          color: Colors.white,
        )
            .animate(target: provider.isBoxShown ? 1 : 0)
            .rotate(begin: 0, end: -1.0472 * 3, duration: 50.ms),
      ),
    )).animate(target: provider.isBoxShown ? 1 : 0);
    //.moveY(begin: -200, end: 0, duration: 50.ms);
  }
}
