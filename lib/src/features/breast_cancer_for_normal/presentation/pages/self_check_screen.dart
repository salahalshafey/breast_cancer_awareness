import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../widgets/custom_texts.dart';

class SelfCheckScreen extends StatefulWidget {
  static const routName = '/self-check-screen';

  const SelfCheckScreen({super.key});

  @override
  State<SelfCheckScreen> createState() => _SelfCheckScreenState();
}

class _SelfCheckScreenState extends State<SelfCheckScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    // Hide status and navigation bars (full screen)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
    // prevent the screen from sleeping
    Wakelock.enable();

    super.initState();
  }

  @override
  void dispose() {
    // Reset system UI overlays when the page is disposed
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    // turning the screen sleeping back to default
    Wakelock.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      containingAppBar: false,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const Text("Self-check with page navigator"),
          const SizedBox(height: 20),
          SizedBox(
            height: 600,
            child: PageView(
              controller: _pageController,
              onPageChanged: (pageindex) {
                setState(() {
                  _currentPageIndex = pageindex;
                });
              },
              children: _selfCheckSteps
                  .map((selfCheckStep) => SelfCheckItem(
                        selfCheckStep.title,
                        selfCheckStep.description,
                        selfCheckStep.image,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          const Text("dotes navigator"),
        ],
      ),
    );
  }
}

class SelfCheckItem extends StatelessWidget {
  const SelfCheckItem(this.title, this.description, this.image, {super.key});

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenSize = MediaQuery.of(context).size;

    final double imageWidth = (orientation == Orientation.portrait)
        ? screenSize.width - 60
        : screenSize.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextTitle(data: title, fontSize: 24),
        TextNormal(data: description, fontSize: 22),
        Image.asset(image, width: imageWidth),
      ],
    );
  }
}

class SelfCheckStep {
  final String title;
  final String description;
  final String image;

  const SelfCheckStep(this.title, this.description, this.image);
}

const List<SelfCheckStep> _selfCheckSteps = [
  SelfCheckStep(
    "Start",
    "Start in an upright position, hands on your hips. "
        "Look at your breasts with the help of a mirror, your mobile phone, or a friend.",
    "assets/breast_cancer/examination_1.jpeg",
  ),
  SelfCheckStep(
    "Look",
    "Do you see any changes in size, shape or colour? Swelling? Puckering of the skin?"
        " Raise your arms and check again.",
    "assets/breast_cancer/examination_2.jpeg",
  ),
  SelfCheckStep(
    "Feel",
    "Use the pads of your fingers and feel your breast. Follow a pattern."
        " Feel for lumps, hardened knots and thickenings.",
    "assets/breast_cancer/examination_3.jpeg",
  ),
  SelfCheckStep(
    "Circles",
    "keep your fingers together and flat. Move in small circles. Repeat using light, medium and then firm pressure."
        " With firm pressure, you should feel your ribcage.",
    "assets/breast_cancer/examination_4.jpeg",
  ),
  SelfCheckStep(
    "Armpit",
    "Cover all the way up to your armpit. The left hand feels the right side and the right hand feels the left side.",
    "assets/breast_cancer/examination_5.jpg",
  ),
  SelfCheckStep(
    "Nipple",
    "Squeeze the nipple. Is there any unusual discharge?",
    "assets/breast_cancer/examination_6.jpeg",
  ),
  SelfCheckStep(
    "Lie down",
    "Lie down so the tissue spreads out evenly. Repeat the examination of your breasts.",
    "assets/breast_cancer/examination_7.jpeg",
  ),
  SelfCheckStep(
    "Helpful hint: Shower",
    "You can do your self-check under the shower."
        " Sometimes it's easier when the breast is wet and soapy.",
    "assets/breast_cancer/examination_8.jpeg",
  ),
];
