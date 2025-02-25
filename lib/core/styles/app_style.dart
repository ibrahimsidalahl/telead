import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle style24(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
    );
  }
  static TextStyle styleOrange16(BuildContext context) {
    return TextStyle(
      color: Color(0xffFF6B00),
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle style20(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.sp,
    );
  }  static TextStyle styleBold20(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.sp,
      fontWeight:FontWeight.bold
    );
  }
  static TextStyle style16(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    );
  }  static TextStyle stylegrey16(BuildContext context) {
    return TextStyle(
      color: Colors.grey[700],
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleGray14(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).disabledColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleGray20(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).disabledColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleBlack20(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle styleGray18(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).disabledColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
    );
  }
}
