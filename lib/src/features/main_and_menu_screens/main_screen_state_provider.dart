import 'package:flutter/material.dart';

import '../../dispose_container.dart';

class MainScreenState extends DisposableProvider {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool _didLunchSelfCheckScreenOnce = false;
  bool _appCheckedForUpdate = false;

  int get currentPageIndex => _currentPageIndex;
  PageController get pageController => _pageController;

  bool get didLunchSelfCheckScreenOnce => _didLunchSelfCheckScreenOnce;
  bool get appCheckedForUpdate => _appCheckedForUpdate;

  void setAsAlreadyLunchedSelfCheckScreenOnce() {
    _didLunchSelfCheckScreenOnce = true;
    // notifyListeners();
  }

  void setAsAlreadyCheckedForUpdate() {
    _appCheckedForUpdate = true;
    // notifyListeners();
  }

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
    _appCheckedForUpdate = false;
  }
}
