import 'package:flutter/material.dart';

import '../../../../../core/theme/theme.dart';

class OnBoardingProvider with ChangeNotifier {
  PageController _pageController = PageController();
  int _currentPage = 0;


  int get currentPage => _currentPage;
  PageController get pageController=> _pageController;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  set pageController(PageController value) {
    _pageController = value;
    notifyListeners();
  }
  void updateCurrentIndex(int index) {
    currentPage = index;
  }


}
