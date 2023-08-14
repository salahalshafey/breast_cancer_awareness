import 'package:flutter/material.dart';

class AddNotesStateProvider with ChangeNotifier {
  String? _text;
  String? _recordFilePath;
  String? _imageFilePath;

  String? get text => _text;
  String? get recordFilePath => _recordFilePath;
  String? get imageFilePath => _imageFilePath;

  void setText(String? text) {
    _text = text;
    notifyListeners();
  }

  void setRecord(String? recordFilePath) {
    _recordFilePath = recordFilePath;
    notifyListeners();
  }

  void setImage(String? imageFilePath) {
    _imageFilePath = imageFilePath;
    notifyListeners();
  }
}
