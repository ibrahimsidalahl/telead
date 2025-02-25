import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'on_boarding_page_view.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  static const routeName = 'onBoarding';

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: SafeArea(child: OnBoardingPageView()),
    );
  }
}