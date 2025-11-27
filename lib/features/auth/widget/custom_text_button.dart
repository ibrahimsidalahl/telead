import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool isLoading;

  const CustomTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite, // 80% من عرض الشاشة
      height: 50.h, // ارتفاع مناسب (responsive)
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xff0961F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  // year2023: true,
                  color: Colors.white,
                ),
              )
            : Text(
                title,
                style:  TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
      ),
    );
  }
}
