import 'dart:math';

import 'package:breast_cancer_awareness/src/features/main_and_menu_screens/main_screen_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../articles/presentation/pages/for_patients_screen.dart';
import '../articles/presentation/pages/home_screen.dart';
import '../breast_cancer_detection/presentation/pages/for_doctors_screen.dart';
import '../settings/widgets/set_theme_mode.dart';
import '../account/presentation/widgets/icon_from_asset.dart';
import '../account/presentation/providers/account.dart';

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
    final shapeHeight = screenSize.width * (isportrait ? 0.30 : 0.13);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          ////////// backGround image ////////////
          Opacity(
            opacity:
                Theme.of(context).brightness == Brightness.light ? 0.16 : 0.12,
            child: Image.asset(
              "assets/images/background_image.png",
              height: isportrait ? screenSize.height : null,
              width: isportrait ? null : screenSize.width,
              fit: isportrait ? BoxFit.fitHeight : BoxFit.fitWidth,
            ),
          ),

          //////// The pages that can be scrolled between /////////
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: shapeHeight - 5,
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
          const Positioned(
            bottom: 0,
            child: ShapeForMainScreen(angle: pi),
          ),
          Positioned(
            bottom: 0,
            child: CustomBottomNavigationBar(
              onSelected: provider.animateToPage,
              currentSelectedIndex: provider.currentPageIndex,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onSelected,
    required this.currentSelectedIndex,
  });

  final void Function(int index) onSelected;
  final int currentSelectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIcon(
            index: 0,
            assetIcon: const IconFromAsset(
              assetIcon: "assets/icons/home_icon.svg",
              iconHeight: 45,
            ),
            isSelected: currentSelectedIndex == 0,
            onTap: onSelected,
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: CustomIcon(
              index: 1,
              assetIcon: const IconFromAsset(
                assetIcon: "assets/icons/doctor_icon.png",
                iconHeight: 70,
              ),
              isSelected: currentSelectedIndex == 1,
              onTap: onSelected,
            ),
          ),
          CustomIcon(
            index: 2,
            assetIcon: const IconFromAsset(
              assetIcon: "assets/icons/patient_icon.svg",
              iconHeight: 40,
            ),
            isSelected: currentSelectedIndex == 2,
            onTap: onSelected,
          ),
        ],
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.index,
    required this.assetIcon,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final IconFromAsset assetIcon;
  final bool isSelected;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: assetIcon.assetIcon.contains("patient")
          ? const BoxDecoration(
              color: Color.fromRGBO(190, 215, 255, 1),
              shape: BoxShape.circle,
              border: Border.fromBorderSide(BorderSide(color: Colors.white)),
            )
          : null,
      child: IconButton(
        icon: assetIcon,
        onPressed: () => onTap(index),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scaleXY(end: 1.1, duration: 250.ms)
        .fade(begin: 0.47, end: 1);
  }
}

class ShapeForMainScreen extends StatelessWidget {
  const ShapeForMainScreen({
    super.key,
    required this.angle,
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    final shapeWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Transform.rotate(
      angle: angle,
      child: CustomPaint(
        size: Size(shapeWidth, shapeWidth * (isPortrait ? 0.30 : 0.13)),
        painter: PaintForMainScreen(isDark: isDark),
      ),
    );
  }
}

class PaintForMainScreen extends CustomPainter {
  PaintForMainScreen({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = isDark
          ? const Color.fromARGB(255, 168, 123, 141)
          : const Color.fromRGBO(246, 168, 201, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width, 0);
    path0.quadraticBezierTo(
        size.width * 1.0180000, size.height * -0.0714815, size.width, 0);
    path0.cubicTo(
        size.width * 0.8120000,
        size.height * 1.2833333,
        size.width * 0.1860000,
        size.height * 1.2940741,
        0,
        size.height * 0.0029630);
    path0.quadraticBezierTo(0, size.height * 0.0022222, 0, 0);
    path0.lineTo(size.width, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    //(shape) appBar and bottom navigation bar
    final shapeWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final shapeHeight = shapeWidth * (isPortrait ? 0.30 : 0.13);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: shapeHeight + 10,
        ),
        children: const [
          Text("Main Screens Will Be Here"),
          SizedBox(height: 20),
          SignOut(),
          SizedBox(height: 20),
          GetUserData(),
          SizedBox(height: 20),
          SetThemeMode(),
          Text("Main Screens Will Be Here"),
          SizedBox(height: 20),
          SignOut(),
          SizedBox(height: 20),
          GetUserData(),
          SizedBox(height: 20),
          SetThemeMode(),
          Text("Main Screens Will Be Here"),
          SizedBox(height: 20),
          SignOut(),
          SizedBox(height: 20),
          GetUserData(),
          SizedBox(height: 20),
          SetThemeMode(),
        ],
      ),
    );
  }
}

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Provider.of<Account>(context, listen: false).signOut();
      },
      child: const Text("sign out"),
    );
  }
}

class GetUserData extends StatelessWidget {
  const GetUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final account = Provider.of<Account>(context, listen: false);
        final info = await account.getUserInfo();
        // ignore: avoid_print
        print(info);
      },
      child: const Text("get user data"),
    );
  }
}

/*color: Theme.of(context).colorScheme.background,
  colorBlendMode: BlendMode.hardLight,

colorFilter: ColorFilter.mode(
             Theme.of(context).colorScheme.background,
             BlendMode.hardLight,
                ),*/

extension ListExtensions<T> on List<T> {
  List<T> rotated() {
    if (isEmpty || length == 1) {
      return this;
    }

    final modefiedList = this;

    final theLast = modefiedList.last;
    modefiedList.removeLast();
    modefiedList.insert(0, theLast);
    return modefiedList;
  }

  void rotate() {
    if (isEmpty || length == 1) {
      return;
    }

    final theLast = last;
    removeLast();
    insert(0, theLast);
  }
}
