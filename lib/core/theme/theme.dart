import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor:  Colors.black,
  disabledColor: Colors.grey[600],
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xff0961F5),
    unselectedItemColor: Colors.grey,
  ),
  secondaryHeaderColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.black, size: 12.sp),
);

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.white,
  disabledColor: Colors.grey,
  iconTheme: IconThemeData(color: Colors.white, size: 12.sp),
  secondaryHeaderColor: Colors.white12,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: Color(0xff0961F5),
    unselectedItemColor: Colors.grey,
  ),
);
