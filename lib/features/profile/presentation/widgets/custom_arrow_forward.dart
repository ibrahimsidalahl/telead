import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomArrowForward extends StatelessWidget {
  const CustomArrowForward({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios_sharp,
      size: 20.sp,
    );
  }
}
