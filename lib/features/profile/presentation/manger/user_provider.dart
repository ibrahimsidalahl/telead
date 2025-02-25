import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/firebase_services/firebase_services.dart';
import '../../../auth/data/user_model.dart';

class UsersProvider extends ChangeNotifier {
  // This should be a single user if fetching by ID, unless you want multiple users.
  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Fetch a single user by ID
  Future<UserModel?> fetchUserData(String id ) async {
    _isLoading = true;
    notifyListeners();

    try {
      FirebaseServices firebaseServices = FirebaseServices();
      _user = await firebaseServices.getUserData(id);
      print('${_user}');
    } catch (e) {
      _errorMessage = e.toString();
      print("Error fetching user data: $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
