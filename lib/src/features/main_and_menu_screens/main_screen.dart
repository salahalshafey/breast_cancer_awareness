import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../core/util/builders/on_will_pop_dialog.dart';
import 'main_screen_state_provider.dart';

import '../articles/presentation/pages/for_patients_screen.dart';
import '../articles/presentation/pages/home_screen.dart';
import '../breast_cancer_detection/presentation/pages/for_doctors_screen.dart';

import '../account/presentation/widgets/icon_from_asset.dart';
import 'widgets/custom_navigation_bar.dart';
import 'widgets/shape_for_main_screen.dart';

class MainScreen extends StatelessWidget {
  static const routName = '/main-screen';

  const MainScreen({super.key});

  static const List<String> _screenTitles = [
    "Home",
    "For Doctors",
    "For Patients"
  ];

  static const List<Widget> _screenOptions = <Widget>[
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

    return WillPopScope(
      onWillPop: () => onWillPopWithDialog(context),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            ////////// backGround image ////////////
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
              left: 20,
              child: IconButton(
                tooltip: "Open Menu",
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
