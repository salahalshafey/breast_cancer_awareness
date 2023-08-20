import 'package:flutter/material.dart';

import '../../../../../core/util/widgets/default_screen.dart';

import '../../../../account/presentation/widgets/icon_from_asset.dart';
import '../../widgets/custom_texts.dart';

class ShouldLookForScreen extends StatelessWidget {
  const ShouldLookForScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      child: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
        children: [
          const SizedBox(height: 20),
          const Text(
            "What to look for",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          ...thingsToLookFor.map((thingToLookFor) => ShouldLookForItem(
                thingToLookFor.title,
                thingToLookFor.image,
                thingToLookFor.description,
              )),
          const IconFromAsset(
            assetIcon: "assets/images/background_cancer_sympol.png",
            iconHeight: 150,
            opacity: 0.62,
          ),
        ],
      ),
    );
  }
}

class ShouldLookForItem extends StatelessWidget {
  const ShouldLookForItem(
    this.title,
    this.image,
    this.description, {
    super.key,
  });

  final String title;
  final String image;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextTitle(data: title, fontSize: 24),
        const SizedBox(height: 20),
        Image.asset(image, height: 200),
        const SizedBox(height: 20),
        TextNormal(data: description, fontSize: 22),
        const SizedBox(height: 40),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////// that data used for should look for screen ///////////////////
////////////////////////////////////////////////////////////////////////////////

class ThingToLookFor {
  final String title;
  final String image;
  final String description;

  const ThingToLookFor(this.title, this.image, this.description);
}

const List<ThingToLookFor> thingsToLookFor = [
  ThingToLookFor(
    "Lumps, knots, thickenings",
    "assets/breast_cancer/look_for_1.jpeg",
    "Lumps, hardened knots or thickenings in the breast tissue can be a sign of breast cancer."
        " They can occur right under the skin, in the middle of the breast or in the deep tissue near the bones.",
  ),
  ThingToLookFor(
    "Changes in size or shape",
    "assets/breast_cancer/look_for_2.jpeg",
    "Unusual changes in size, contour or shape should be checked. The same is true for distortions or swellings."
        " Keep in mind that your left and right breast might look different. Know what is normal for you.",
  ),
  ThingToLookFor(
    "Nipple discharge",
    "assets/breast_cancer/look_for_3.jpeg",
    "The nipple should look normal to you, and should be free from irritation."
        " Check for unusual discharge of fluid or blood",
  ),
  ThingToLookFor(
    "Skin changes",
    "assets/breast_cancer/look_for_4.jpeg",
    "There should be no strange wrinkling or bulging of the skin."
        " Get checked if there is any persistent redness, soreness or rash, especially if only on one side.",
  ),
];
