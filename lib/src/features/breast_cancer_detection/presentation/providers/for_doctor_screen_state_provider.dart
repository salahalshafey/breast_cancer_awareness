import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../dispose_container.dart';

class ForDoctorScreenState extends DisposableProvider {
  bool _isBoxShown = false;
  bool _isBoxResetted = false;
  File? _fileImage;
  String? _networkImage;

  var _formKey = GlobalKey<FormState>();
  bool _isTextFieldIconShowen = false;
  bool _isTextFieldLaodinShowen = false;

  bool get isBoxShown => _isBoxShown;

  bool get isBoxResetted => _isBoxResetted;

  File? get fileImage => _fileImage;

  String? get networkImage => _networkImage;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isTextFieldIconShowen => _isTextFieldIconShowen;

  bool get isTextFieldLoadinShowen => _isTextFieldLaodinShowen;

  void togoleBoxShown() {
    if (_isBoxShown) {
      resetBox();
    }

    _isBoxShown = !_isBoxShown;
    notifyListeners();
  }

  void setBoxNotRestted() {
    _isBoxResetted = false;
    notifyListeners();
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

  void setTextFieldLoading(bool state) {
    _isTextFieldLaodinShowen = state;
    notifyListeners();
  }

  void resetBox() {
    _formKey = GlobalKey<FormState>();

    if (_fileImage == null && _networkImage == null) {
      _formKey.currentState?.reset();
    }
    _fileImage = null;
    _networkImage = null;
    _isTextFieldIconShowen = false;
    _isTextFieldLaodinShowen = false;
    _isBoxResetted = true;

    notifyListeners();
  }

  @override
  void disposeValues() {
    _isBoxShown = false;
    _isBoxResetted = false;
    _fileImage = null;
    _networkImage = null;
    _isTextFieldIconShowen = false;
    _isTextFieldLaodinShowen = false;
  }
}
