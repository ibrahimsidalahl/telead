import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';

class SigninWithWidget extends StatelessWidget {
  final String image;
  final String title;

  const SigninWithWidget({required this.title, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25), // Shadow color
                  offset: Offset(2, 4), // Shadow position (x, y)
                  blurRadius: 6, // Blur effect
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Color(0xffffffff),
              radius:18.r,
              backgroundImage: AssetImage(image),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            title,
            style: AppStyles.stylegrey16(context),
          )
        ],
      ),
    );
  }
}
