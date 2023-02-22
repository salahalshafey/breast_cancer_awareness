import 'package:flutter/material.dart';

class MainScreenState with ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPageIndex = 1;

  int get currentPageIndex => _currentPageIndex;

  PageController get pageController => _pageController;

  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void animateToPage(int pageIndex) {
    int animationDurationInmilliseconds = 250;
    if ((pageIndex - _currentPageIndex).abs() > 1) {
      animationDurationInmilliseconds = 100;
    }

    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: animationDurationInmilliseconds),
      curve: Curves.easeInOut,
    );

    _currentPageIndex = pageIndex;
    notifyListeners();
  }

  void jumpToPage(int pageIndex) {
    _pageController.jumpToPage(pageIndex);

    _currentPageIndex = pageIndex;
    notifyListeners();
  }
}
