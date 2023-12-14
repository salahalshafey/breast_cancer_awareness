import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app.dart';
import '../../core/util/builders/on_will_pop_dialog.dart';
import 'main_screen_state_provider.dart';

import '../breast_cancer_for_normal/presentation/pages/home_screen.dart';
import '../breast_cancer_detection/presentation/pages/for_doctors_screen.dart';
import '../breast_cancer_for_patient/presentation/pages/for_patients_screen.dart';

import '../account/presentation/widgets/icon_from_asset.dart';
import 'widgets/custom_navigation_bar.dart';
import 'widgets/shape_for_main_screen.dart';

class MainScreen extends StatelessWidget {
  static const routName = '/main-screen';

  const MainScreen({super.key});

  List<String> get _screenTitles {
    final context = navigatorKey.currentContext!;

    return [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.forDoctors,
      AppLocalizations.of(context)!.forPatients,
    ];
  }

  static const _screenOptions = <Widget>[
    HomeScreen(key: PageStorageKey('HomeScreen')),
    ForDoctorsScreen(key: PageStorageKey('ForDoctorsScreen')),
    ForPatientsScreen(key: PageStorageKey('ForPatientsScreen')),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainScreenState>(context);

    final screenSize = MediaQuery.of(context).size;
    final isportrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (provider.currentPageIndex != 0) {
          provider.animateToPage(0);
          return;
        }

        // final navigator = Navigator.of(context);
        final shouldPop = await exitWillPopDialog(context);
        if (shouldPop) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // navigator.pop();
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            ////////// backGround image ////////////
            if (Theme.of(context).brightness == Brightness.light)
              Positioned(
                bottom: isportrait ? 0 - keyboardHeight : null,
                child: Opacity(
                  opacity: Theme.of(context).brightness == Brightness.light
                      ? 0.16
                      : 0.12,
                  child: Image.asset(
                    "assets/images/background_image.png",
                    height: isportrait ? screenSize.height : null,
                    width: isportrait ? null : screenSize.width,
                    fit: isportrait ? BoxFit.fitHeight : BoxFit.fitWidth,
                  ),
                ),
              ),

            //////// The pages that can be scrolled between /////////
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: PageView(
                controller: provider.pageController,
                onPageChanged: provider.setCurrentPageIndex,
                children: _screenOptions,
              ),
            ),

            //////////////// AppBar ////////////////////
            const Positioned(
              top: 0,
              child: ShapeForMainScreen(angle: 0),
            ),
            Positioned(
              top: 40,
              child: Text(
                _screenTitles[provider.currentPageIndex],
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            Positioned(
              top: 40,
              left: Directionality.of(context) == TextDirection.ltr ? 20 : null,
              right:
                  Directionality.of(context) == TextDirection.rtl ? 20 : null,
              child: IconButton(
                tooltip: AppLocalizations.of(context)!.openMenu,
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: const IconFromAsset(
                  assetIcon: "assets/icons/drawer_icon.png",
                  iconHeight: 40,
                ),
              ),
            ),

            /////////// Bottom Navigation Bar //////////////
            Positioned(
              bottom: 0 - keyboardHeight,
              child: const ShapeForMainScreen(angle: pi),
            ),
            Positioned(
              bottom: 0 - keyboardHeight,
              child: CustomBottomNavigationBar(
                onSelected: provider.animateToPage,
                currentSelectedIndex: provider.currentPageIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
