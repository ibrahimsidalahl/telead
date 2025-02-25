import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/firebase_services/firebase_services.dart';
import '../../data/models/category_model.dart';
import '../../data/models/course_model.dart';

class CoursesProvider extends ChangeNotifier {
  List<CourseModel> _courses = [];
  List<CourseModel> get courses => _courses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchData(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      FirebaseServices firebaseServices = FirebaseServices();
      _courses = await firebaseServices.fetchAllCourses(id);
    } catch (e) {
      _errorMessage = e.toString();
      print("Error fetching categories: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
