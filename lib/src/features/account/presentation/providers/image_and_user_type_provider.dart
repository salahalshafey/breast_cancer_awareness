import 'dart:io';

import 'package:flutter/material.dart';

class ImageAndUserTypeProvider with ChangeNotifier {
  File? _previousImage;
  File? _currentImage;
  String _userType = "";

  File? get previousImage => _previousImage;
  File? get currentImage => _currentImage;
  String get userType => _userType;

  void changeImage(String imagePath) {
    _previousImage = _currentImage;
    _currentImage = File(imagePath);
    notifyListeners();
  }

  void changeUserType(String userType) {
    _userType = userType;
    notifyListeners();
  }
}
