import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/account/presentation/providers/account.dart';
import 'features/breast_cancer_for_normal/presentation/providers/notes.dart';
import 'features/breast_cancer_detection/presentation/providers/for_doctor_screen_state_provider.dart';
import 'features/main_and_menu_screens/main_screen_state_provider.dart';

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}

class AppProviders {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<Account>(context, listen: false),
      Provider.of<Notes>(context, listen: false),
      Provider.of<ForDoctorScreenState>(context, listen: false),
      Provider.of<MainScreenState>(context, listen: false),
      //...other disposable providers
    ];
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }
}
