import 'dart:io';

import 'package:flutter/material.dart';

class ImageAndUserTypeProvider with ChangeNotifier {
  File? _currentImage;
  String _userType = "";

  File? get currentImage => _currentImage;
  String get userType => _userType;

  void changeImage(String imagePath) {
    _currentImage = File(imagePath);
    notifyListeners();
  }

  void changeUserType(String userType) {
    _userType = userType;
    notifyListeners();
  }
}
