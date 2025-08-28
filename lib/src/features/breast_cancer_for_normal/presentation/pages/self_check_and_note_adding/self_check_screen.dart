import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../../../l10n/app_localizations.dart';
import '../../../../../app.dart';
import '../../../../../core/util/widgets/default_screen.dart';

import '../../widgets/custom_texts.dart';
import '../../widgets/self_check/dots_navigator.dart';
import '../../widgets/self_check/self_check_page_navigator.dart';
import '../../widgets/self_check/switch_to_mirror_button.dart';

import 'findings_screen.dart';

class SelfCheckScreen extends StatefulWidget {
  static const routName = '/self-check-screen';

  const SelfCheckScreen({super.key});

  @override
  State<SelfCheckScreen> createState() => _SelfCheckScreenState();
}

class _SelfCheckScreenState extends State<SelfCheckScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final _screenOptions = _selfCheckSteps()
      .map((selfCheckStep) => SelfCheckItem(
            selfCheckStep.title,
            selfCheckStep.description,
            selfCheckStep.image,
          ))
      .toList();

  void _goToPageIndex(int pageIndex) {
    if (pageIndex >= _selfCheckSteps().length || pageIndex < 0) {
      return;
    }

    _pageController.jumpToPage(pageIndex);
  }

  void _goToNextPage() {
    if (_currentPageIndex == _selfCheckSteps().length - 1) {
      Navigator.of(context).pushReplacementNamed(FindingsScreen.routName);
      return;
    }

    _pageController.animateToPage(
      _currentPageIndex + 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _goToPrevPage() {
    if (_currentPageIndex == 0) {
      return;
    }

    _pageController.animateToPage(
      _currentPageIndex - 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int pageindex) async {
    setState(() {
      _currentPageIndex = pageindex;
    });

    if (_currentPageIndex == _selfCheckSteps().length - 1) {
      final screenHeight = MediaQuery.of(context).size.height;

      // all screen widgets height = 875, if you want to animate to the end
      final offsetToNearlyEndOfScreen = 845 - screenHeight;

      await Future.delayed(1.seconds);
      // _scrollController.jumpTo(offset);
      _scrollController.animateTo(
        offsetToNearlyEndOfScreen > 0 ? offsetToNearlyEndOfScreen : 0,
        duration: 500.ms,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    // Hide status and navigation bars (full screen)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
    // prevent the screen from sleeping
    WakelockPlus.enable();

    super.initState();
  }

  @override
  void dispose() {
    // Reset system UI overlays when the page is disposed (exit full screen)
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    // turning the screen sleeping back to default
    WakelockPlus.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      containingBackgroundCancerSympol: false,
      containingAppBar: false,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        controller: _scrollController,
        children: [
          SelfCheckPageNavigator(
            numOfPages: _selfCheckSteps().length,
            currentPageIndex: _currentPageIndex,
            gotToNextPage: _goToNextPage,
            gotToPrevPage: _goToPrevPage,
            color: const Color.fromRGBO(199, 40, 107, 1),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 600,
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _screenOptions,
            ),
          ),
          const SizedBox(height: 20),
          DotsNavigator(
            numOfDots: _selfCheckSteps().length,
            currentPageIndex: _currentPageIndex,
            colorOfDots: Colors.grey,
            colorOfCurrentDot: const Color.fromRGBO(199, 40, 107, 1),
            gotToPageIndex: _goToPageIndex,
          ),
          if (_currentPageIndex == _selfCheckSteps().length - 1)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(FindingsScreen.routName);
                  },
                  child:
                      Text(AppLocalizations.of(context)!.continueToMainScreen),
                ),
              ),
            ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextTitle(data: title, fontSize: 24),
        TextNormal(data: description, fontSize: 20),
        Expanded(
          child: Center(
            child: Stack(
              children: [
                Image.asset(image),
                ...switchToMirrorButton(context),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 1.seconds);
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////// that data used for self-check screen ////////////////////////
////////////////////////////////////////////////////////////////////////////////

class SelfCheckStep {
  final String title;
  final String description;
  final String image;

  const SelfCheckStep(this.title, this.description, this.image);
}

List<SelfCheckStep> _selfCheckSteps() {
  final context = navigatorKey.currentContext!;

  return [
    SelfCheckStep(
      AppLocalizations.of(context)!.start,
      AppLocalizations.of(context)!.startDetails,
      "assets/breast_cancer/examination_1.jpeg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.look,
      AppLocalizations.of(context)!.lookDetails,
      "assets/breast_cancer/examination_2.jpeg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.feel,
      AppLocalizations.of(context)!.feelDetails,
      "assets/breast_cancer/examination_3.jpeg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.circles,
      AppLocalizations.of(context)!.circlesDetails,
      "assets/breast_cancer/examination_4.jpeg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.armpit,
      AppLocalizations.of(context)!.armpitDetails,
      "assets/breast_cancer/examination_5.jpg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.nipple,
      AppLocalizations.of(context)!.nippleDetails,
      "assets/breast_cancer/examination_6.jpeg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.lieDown,
      AppLocalizations.of(context)!.lieDownDetails,
      "assets/breast_cancer/examination_7.jpeg",
    ),
    SelfCheckStep(
      AppLocalizations.of(context)!.helpfulHintShower,
      AppLocalizations.of(context)!.helpfulHintShowerDetails,
      "assets/breast_cancer/examination_8.jpeg",
    ),
  ];
}
