import 'package:flutter/material.dart';

class ToggleCategoryProvider extends ChangeNotifier {


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  int _selectedCategoryId = 0 ;
  int get selectedCategoryId => _selectedCategoryId;
  void set selectedCategoryId(int value) {
    _selectedCategoryId = value;
    notifyListeners();
  }
  void ToggleCategory(String category_id){
    _selectedCategoryId == category_id;


  }




}
