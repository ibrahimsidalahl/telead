
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/features/lets_you_in/features/screens/lets_you_in_screen.dart';

import '../../../../core/styles/app_style.dart';

class OnboardingViewComponent extends StatelessWidget {
  final String text1; // Use final for immutable fields
  final String text2;
  final String image;

  OnboardingViewComponent({
    Key? key,
    required this.text1,
    required this.text2,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, LetsYouInScreen.routeName);

              },
              child: Text(
                'skip',
                style: AppStyles.styleGray20(context),
              ),
            ),
          ],
        ),
        Center(child: Container(
            height: 400.h,

            child: Image.asset(image)),),

        Text(
          text1,
          style: AppStyles.style24(context),
        ),
        Container(
          child: Center(
            child: Text(
              text2,
              style: AppStyles.styleGray14(context),
            ),
          ),
        ),
      ],
    );
  }
}
