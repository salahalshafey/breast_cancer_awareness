import 'dart:io';

import 'package:flutter/material.dart';

class ForDoctorScreenState with ChangeNotifier {
  bool _isBoxShown = false;
  File? _fileImage;
  String? _networkImage;
  final _formKey = GlobalKey<FormState>();

  bool get isBoxShown => _isBoxShown;

  File? get fileImage => _fileImage;

  String? get networkImage => _networkImage;

  GlobalKey<FormState> get formKey => _formKey;

  void togoleBoxShown() {
    _isBoxShown = !_isBoxShown;

    resetBox();
  }

  void setFileImage(File fileImage) {
    _fileImage = fileImage;
    notifyListeners();
  }

  void setNetworkImage(String imageUrl) {
    _networkImage = imageUrl;
    notifyListeners();
  }

  void resetBox() {
    _fileImage = null;
    _networkImage = null;
    // _formKey.currentState!.reset();
    notifyListeners();
  }
}
