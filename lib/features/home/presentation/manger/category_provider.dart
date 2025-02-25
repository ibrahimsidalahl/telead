import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/firebase_services/firebase_services.dart';
import '../../data/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel>? _categories;
  List<CategoryModel>? get categories => _categories;

  void set categories(List<CategoryModel>? value) {
    _categories = value;
    notifyListeners();
  }


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  void set errorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }


  Future<List<CategoryModel>?> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      FirebaseServices firebaseServices = FirebaseServices();
      _categories = await firebaseServices.fetchAllCategories();
      print(_categories);
    } catch (e) {
      _errorMessage = e.toString();
      print("Error fetching categories: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _categories;
  }
}
