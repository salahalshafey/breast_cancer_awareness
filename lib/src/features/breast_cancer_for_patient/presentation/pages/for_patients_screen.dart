import 'package:flutter/material.dart';

import '../../../../core/util/widgets/custom_card.dart';

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
          //  for (int i = 0; i < 2; i++)
          ForPatientsItem(
            image: "assets/breast_cancer/tips.png",
            title: "TIPS FOR YOUR VISIT TO THE DOCTOR",
            subTitle:
                "Tips for things to say & do at your doctor's appointment.",
            onTap: () {},
          ),
          ForPatientsItem(
            image: "assets/breast_cancer/other_resources.png",
            title: "OTHER RESOURCES",
            subTitle: "Take a look at some other helpful resources.",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ForPatientsItem extends StatelessWidget {
  const ForPatientsItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final String image;
  final String title;
  final String subTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subTitle, textAlign: TextAlign.center),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
