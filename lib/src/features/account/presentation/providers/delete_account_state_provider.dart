import 'package:flutter/material.dart';

class DeleteAccountState with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoadingState(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}
