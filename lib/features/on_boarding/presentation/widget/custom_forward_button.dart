import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForwardButton extends StatelessWidget {
  const CustomForwardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xff0961F5),
      radius: 30.r,
      child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 32.sp,
          )),
    );
  }
}
