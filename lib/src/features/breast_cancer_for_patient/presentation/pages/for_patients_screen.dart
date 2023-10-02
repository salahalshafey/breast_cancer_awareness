import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/util/builders/go_to_screen_with_slide_transition.dart';

import '../widgets/for_patients_item.dart';
import 'other_resources_screen.dart';
import 'search_screen.dart';
import 'tips_for_your_visit_screen.dart';

class ForPatientsScreen extends StatelessWidget {
  const ForPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final shapeHeight = screenSize.width * (isportrait ? 0.30 : 0.13);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GridView(
          padding: EdgeInsets.symmetric(vertical: shapeHeight + 10),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: screenSize.width / (isportrait ? 2 : 3),
            mainAxisSpacing: isportrait ? 20.0 : 40.0,
            crossAxisSpacing: isportrait ? 20.0 : 40.0,
            childAspectRatio: isportrait ? 0.43 : 0.50,
          ),
          children: [
            ForPatientsItem(
              image: "assets/breast_cancer/tips.png",
              title: "TIPS FOR YOUR VISIT TO THE DOCTOR",
              subTitle:
                  "Tips for things to say & do at your doctor's appointment.",
              onTap: () => goToScreenWithSlideTransition(
                context,
                const TipsForYourVisit(),
              ),
            ),
            ForPatientsItem(
              image: "assets/breast_cancer/search.png",
              title: "Search about breast cancer".toUpperCase(),
              subTitle: "Search for info OR ask AI for guidance",
              onTap: () => goToScreenWithSlideTransition(
                context,
                const SearchScreen(),
              ),
            ),
            ForPatientsItem(
              image: "assets/breast_cancer/diet.png",
              title: "CANCER & NUTRITION",
              subTitle:
                  "Information and guidelines for maintaining a healthy diet during cancer treatment.",
              onTap: () {
                launchUrl(
                  Uri.parse(
                      "https://breastcancernow.org/information-support/facing-breast-cancer/living-beyond-breast-cancer/your-body/diet-during-breast-cancer-treatment"),
                  mode: LaunchMode.inAppWebView,
                );
              },
            ),
            ForPatientsItem(
              image: "assets/breast_cancer/exercise.png",
              title: "Exercise & physical activity".toUpperCase(),
              subTitle: "Regular exercise and physical activity are essential.",
              onTap: () {
                launchUrl(
                  Uri.parse(
                      "https://breastcancernow.org/information-support/facing-breast-cancer/living-beyond-breast-cancer/your-body/exercise-breast-cancer"),
                  mode: LaunchMode.inAppWebView,
                );
              },
            ),
            ForPatientsItem(
              image: "assets/breast_cancer/other_resources.png",
              title: "OTHER RESOURCES",
              subTitle: "Take a look at some other helpful resources.",
              onTap: () => goToScreenWithSlideTransition(
                context,
                const OtherResourcesScreen(),
              ),
            ),
          ].animate(interval: 100.ms).fade().moveY()
          //.elevation(borderRadius: BorderRadius.circular(25)),
          ),
    );
  }
}
