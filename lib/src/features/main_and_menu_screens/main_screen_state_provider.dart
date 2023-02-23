import 'package:flutter/material.dart';

import '../../dispose_container.dart';

class MainScreenState extends DisposableProvider {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  PageController get pageController => _pageController;

  /* PageController initializePageController(PageController pageController) {
    _pageController = pageController;
    return _pageController;
  }*/

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

  @override
  void disposeValues() {
    // _pageController.dispose();
    _currentPageIndex = 0;
  }
}
