import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/util/widgets/text_well_formatted.dart';

import '../../../../core/util/widgets/note_description.dart';
import '../widgets/box_content.dart';
import '../widgets/image.dart';
import '../widgets/add_and_show_result_button.dart';

import '../providers/for_doctor_screen_state_provider.dart';
import '../widgets/styled_text.dart';

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
          StyledText(
            text: AppLocalizations.of(context)!
                .pickAMedicalImageOfBreastCancerMammogramXrayOrHistologyOfThePatient,
          ),
          const SizedBox(height: 15),
          StyledText(
            text: AppLocalizations.of(context)!
                .seeTheResultOrPredictionUsingTheDeepLearningModels,
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
                  maxHeight: 450 * 0.75,
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
          const SizedBox(height: 20),
          NoteDescription(
            icon: Icon(
              Icons.warning_rounded,
              size: 50,
              color: Colors.red.shade900,
            ).animate(
              onPlay: (controller) {
                controller.loop(count: 10, reverse: true);
              },
            ).scaleXY(begin: 1, end: 1.2, duration: 500.ms),
            title: AppLocalizations.of(context)!.caution,
            titleStyle: TextStyle(
              color: Colors.red.shade900,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            child: TextWellFormattedWithBulleted(
              data: AppLocalizations.of(context)!
                  .thisAiModelsAreToolsForAssistingMedicalProfessionals,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
