import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../dispose_container.dart';

class ForDoctorScreenState extends DisposableProvider {
  bool _isBoxShown = false;
  File? _fileImage;
  String? _networkImage;

  final _formKey = GlobalKey<FormState>();
  bool _isTextFieldIconShowen = false;

  bool get isBoxShown => _isBoxShown;

  File? get fileImage => _fileImage;

  String? get networkImage => _networkImage;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isTextFieldIconShowen => _isTextFieldIconShowen;

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

  void setTextFieldIconShowen(bool state) {
    _isTextFieldIconShowen = state;
    notifyListeners();
  }

  void resetBox() {
    if (_fileImage == null && _networkImage == null) {
      _formKey.currentState!.reset();
    }
    _fileImage = null;
    _networkImage = null;
    _isTextFieldIconShowen = false;

    notifyListeners();
  }

  @override
  void disposeValues() {
    _isBoxShown = false;
    _fileImage = null;
    _networkImage = null;
    _isTextFieldIconShowen = false;
  }
}
