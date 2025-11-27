import 'package:flutter/material.dart';

class ToggleCategoryProvider extends ChangeNotifier {
  int _selectedCategoryId = 0;

  int get selectedCategoryId => _selectedCategoryId;

  set selectedCategoryId(int value) {
    _selectedCategoryId = value;
    notifyListeners();
  }

  void ToggleCategory(String categoryId) {
    _selectedCategoryId == categoryId;
  }
}
