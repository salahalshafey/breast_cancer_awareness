import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/settings/widgets/set_theme_mode.dart';
import 'features/account/presentation/providers/account.dart';

class MainScreen extends StatelessWidget {
  static const routName = '/main-screen';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Main Screens Will Be Here"),
            SizedBox(height: 20),
            SignOut(),
            SizedBox(height: 20),
            GetUserData(),
            SizedBox(height: 20),
            SetThemeMode(),
          ],
        ),
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
