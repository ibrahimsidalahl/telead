import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/core/services/constant.dart';
import 'package:telead/core/services/shared_preferences_singleton.dart';
import 'package:telead/features/lets_you_in/features/screens/lets_you_in_screen.dart';

import '../../../../core/styles/app_style.dart';

class OnboardingViewComponent extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final bool isVisible;

  const OnboardingViewComponent({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Visibility(
            visible: isVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    SharedPreferencesSingleton.setBool(kIsOnBoardingView, true);
                    Navigator.pushNamed(context, LetsYouInScreen.routeName);
                  },
                  child: Text(
                    'skip',
                    style: AppStyles.styleGray20(context),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
                height: 360.h,
                child: Image.asset(
                  image,
                )),
          ),
          Text(
            title,
            style: AppStyles.style24(context),
          ),
          Container(
            child: Center(
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: AppStyles.styleGray14(context).copyWith(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
