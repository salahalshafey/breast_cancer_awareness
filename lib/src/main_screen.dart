import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'features/settings/widgets/set_theme_mode.dart';
import 'features/account/presentation/widgets/icon_from_asset.dart';
import 'features/account/presentation/providers/account.dart';

class MainScreen extends StatefulWidget {
  static const routName = '/main-screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controler = PageController();
  int _currentPageIndex = 0;

  static const List<String> _screenTitles = [
    "Home",
    "For Doctors",
    "For Patients"
  ];

  static const List<Widget> _screenOptions = <Widget>[
    Screen(key: PageStorageKey('HomeScreen')),
    Screen(key: PageStorageKey('ForDoctorsScreen')),
    Screen(key: PageStorageKey('ForPatientsScreen')),
  ];

  void _onPageScrolled(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _onBottomNavigationBarClicked(int index) {
    int animationDurationInmilliseconds = 250;
    if ((index - _currentPageIndex).abs() > 1) {
      animationDurationInmilliseconds = 100;
    }

    _controler.animateToPage(
      index,
      duration: Duration(milliseconds: animationDurationInmilliseconds),
      curve: Curves.easeInOut,
    );

    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortial =
        MediaQuery.of(context).orientation == Orientation.portrait;

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
              height: isPortial ? screenSize.height : null,
              width: isPortial ? null : screenSize.width,
              fit: isPortial ? BoxFit.fitHeight : BoxFit.fitWidth,
            ),
          ),

          //////// The pages that can scroll between /////////
          PageView(
            controller: _controler,
            onPageChanged: _onPageScrolled,
            children: _screenOptions,
          ),

          //////////////// AppBar ////////////////////
          const Positioned(
            top: 0,
            child: ShapeForMainScreen(angle: 0),
          ),
          Positioned(
            top: 40,
            child: Text(
              _screenTitles[_currentPageIndex],
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              onPressed: () {},
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
              onSelected: _onBottomNavigationBarClicked,
              currentSelectedIndex: _currentPageIndex,
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
