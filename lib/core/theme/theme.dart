import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
  disabledColor: Colors.grey[600],

  secondaryHeaderColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.black, size: 12.sp),
);

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.white,
  disabledColor: Colors.grey,
  iconTheme: IconThemeData(color: Colors.white, size: 12.sp),
  secondaryHeaderColor: Colors.white12,
);
