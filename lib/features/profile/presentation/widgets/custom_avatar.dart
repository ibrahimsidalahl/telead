import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvatar extends StatelessWidget {
  CustomAvatar({super.key, required this.url});

  String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
backgroundColor: Colors.white,
      backgroundImage: NetworkImage(url ,),
      radius: 70.r,
    );

  }
}
