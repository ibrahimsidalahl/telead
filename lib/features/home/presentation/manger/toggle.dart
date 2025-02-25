import 'package:flutter/material.dart';

class ToggleProvider extends ChangeNotifier {
  // Colors for switching
  Color _color1 = Colors.white;
  Color _color2 = Colors.grey[200]!;

  // Boolean to keep track of the active state
  bool _isColor1Active = true;

  // Getters for colors
  Color get color1 => _color1;
  Color get color2 => _color2;

  // Method to switch colors
  void toggleColors() {
    _isColor1Active = !_isColor1Active;
    notifyListeners();
  }

  // Getter to get the active color for the first button
  Color get activeColor1 => _isColor1Active ? _color1 : _color2;

  // Getter to get the active color for the second button
  Color get activeColor2 => _isColor1Active ? _color2 : _color1;
}
