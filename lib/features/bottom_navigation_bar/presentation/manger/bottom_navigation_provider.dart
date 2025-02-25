import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();  // Notify listeners whenever the index changes
  }
}
