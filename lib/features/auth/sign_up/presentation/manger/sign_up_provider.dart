import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  String _selectedRole = 'Student';

  String get selectedRole => _selectedRole;

  void setSelectedRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}