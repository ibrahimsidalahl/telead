import 'package:flutter/material.dart';

import '../../../../../core/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isLightMode = true;
  bool _switchActive = false;

  bool get isLightMode => _isLightMode;
  bool get switchActive => _switchActive;

  set isLightMode(bool value) {
    _isLightMode = value;
    notifyListeners();
  }

  set switchActive(bool value) {
    _switchActive = value;
    notifyListeners();
  }
  void toggleMode() {
    if(_isLightMode){
      _isLightMode = false ;
      _switchActive = true ;
    }else{
      _isLightMode = true ;
      _switchActive = false ;
    }
    notifyListeners();
  }


  ThemeData getCurrentTheme() {
    print('=====================================================object');
    return _isLightMode ? lightMode : darkMode;  }
}
