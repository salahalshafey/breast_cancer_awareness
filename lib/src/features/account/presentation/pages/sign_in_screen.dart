import 'package:breast_cancer_awareness/src/core/theme/colors.dart';
import 'package:breast_cancer_awareness/src/features/account/presentation/pages/second_sign_up_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme_provider.dart';
import '../widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInScreen extends StatelessWidget {
  static const routName = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40.0;
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: -205,
            right: -65,
            child: Opacity(
              opacity: 0.58,
              child: SvgPicture.asset(
                "assets/images/background_flower.svg",
                height: 350,
              ),
            ),
          ),
          Positioned(
            bottom: -14 - keyboardHeight,
            left: -165,
            child: Opacity(
              opacity: 0.58,
              child: SvgPicture.asset(
                "assets/images/background_flower.svg",
                height: 350,
              ),
            ),
          ),
          if (Theme.of(context).brightness == Brightness.light)
            Positioned(
              bottom: -15 - keyboardHeight,
              right: 5,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  "assets/images/background_cancer_sympol.png",
                  scale: 3,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: horizantalPadding, vertical: 60),
            children: [
              const SizedBox(height: 35),
              const Text(
                "Log in",
                style: TextStyle(
                  color: Color.fromRGBO(191, 76, 136, 1),
                  fontSize: 26,
                ),
              ),
              const Text(
                "Please sign in to continue",
                style: TextStyle(
                  color: Color.fromRGBO(206, 50, 116, 0.76),
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SecondSignUpScreen.routName);
                },
                child: const Text("go"),
              ),
              const SizedBox(height: 30),
              const SetThemeMode(),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/person_avatar.png",
                  scale: 1.5,
                  filterQuality: FilterQuality.high,
                ),
              ).animate(delay: 1.5.seconds).shimmer(duration: 1.seconds),
              const SizedBox(height: 30),
              const SignInForm(),
            ],
          ),
        ],
      ),
    );
  }
}

class SetThemeMode extends StatelessWidget {
  const SetThemeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Apperance",
            style: TextStyle(
              color: MyColors.appBarForGroundColor,
              fontSize: 18,
            ),
          ),
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return DropdownButton<String>(
                value: provider.currentTheme,
                items: [
                  DropdownMenuItem<String>(
                    value: 'light',
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.light_mode),
                      label: Text(
                        "Light",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'dark',
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.dark_mode),
                      label: Text(
                        "Dark",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: 'system',
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.auto_graph),
                      label: Text(
                        "System default",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                onChanged: (String? value) {
                  provider.changeTheme(value ?? 'system');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
