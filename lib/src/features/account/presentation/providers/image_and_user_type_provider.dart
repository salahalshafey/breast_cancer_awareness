import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/user_information.dart';

class ImageAndUserTypeProvider with ChangeNotifier {
  File? _currentImage;
  UserTypes? _userType;

  File? get currentImage => _currentImage;
  UserTypes? get userType => _userType;

  void changeImage(String imagePath) {
    _currentImage = File(imagePath);
    notifyListeners();
  }

  void changeUserType(UserTypes userType) {
    _userType = userType;
    notifyListeners();
  }
}
