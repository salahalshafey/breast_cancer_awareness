import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/util/widgets/default_screen.dart';
import '../../../../core/util/widgets/bulleted_list.dart';
import '../../../account/presentation/widgets/icon_from_asset.dart';

class TipsForYourVisit extends StatelessWidget {
  const TipsForYourVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      containingBackgroundRightSympol: false,
      child: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
        children: [
          const SizedBox(height: 20),
          const Text(
            "Tips For Your Doctor's Visit",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(199, 40, 107, 1),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 30),
          Image.asset("assets/breast_cancer/tips_for_page.png"),
          const SizedBox(height: 20),
          const Text(
            "Tips for things to say & do at your doctors appointment.\n\n"
            "Remember, we're not medical professionals but we are here to support you."
            " Here are some tips for things to say and do at your appointment,"
            " but we encourage you to do further research.\n\n",
            style: TextStyle(fontSize: 16),
          ),
          const BulletedList(
            text: Text(
              "We want to help provide you with tools to be your own health advocate.\n\n",
              style: TextStyle(fontSize: 16),
            ),
            bullet: SizedBox(width: 5, height: 5),
          ),
          ...tips.map((tip) => BulletedList(
                text: Text(tip, style: const TextStyle(fontSize: 16)),
              )),
          const SizedBox(height: 20),
          const IconFromAsset(
            assetIcon: "assets/images/background_cancer_sympol.png",
            iconHeight: 150,
            opacity: 0.62,
          ),
        ].animate(interval: 100.ms).fade().moveX(),
      ),
    );
  }
}

const tips = <String>[
  "Have your app handy to reference your notes at the doctor's office. It's always good to have information written down, that way you don't forget anything important.\n",
  "Bring someone with you to take notes or ask your doctor if you can record your discussion so you have all the information. Having someone there can help ensure all your questions are answered, or help advocate for you, if necessary.\n",
  "Ask for pamphlets and for their notes to be printed out or emailed to you, if this is not done automatically. Get as much information as you can.\n",
  "Be empowered to get a second opinion. There are lots of reasons this is a good idea. You need to be comfortable with the person you're working with, their diagnosis, and treatment - if there is something to be treated. Your doctor may even be able to refer you to someone else for a second opinion.\n",
];
