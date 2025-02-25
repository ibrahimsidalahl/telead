
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../auth/sign_in/presentation/screens/sign_in_screen.dart';
import '../../../lets_you_in/features/screens/lets_you_in_screen.dart';
import '../manger/on_boarding_provider.dart';
import '../widget/on_boarding_view_component.dart';

class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView({super.key});

  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller:
                  Provider.of<OnBoardingProvider>(context, listen: false)
                      .pageController,
              onPageChanged: (int index) {
                Provider.of<OnBoardingProvider>(context, listen: false)
                    .updateCurrentIndex(index);
              },
              children: [
                OnboardingViewComponent(
                  text1: 'Online Learning',
                  text2:
                      'We Provide Online Classes and Pre Recorded Lectures.!',
                  image: 'assets/onboarding1.png',
                ),
                OnboardingViewComponent(
                  text1: 'Learn from Anytime',
                  text2: 'Booked or Save the Lectures for Future',
                  image: 'assets/onboarding2.png',
                ),
                OnboardingViewComponent(
                  text1: 'Get Online Certificate',
                  text2: 'Analyze your scores and Track your results',
                  image: 'assets/onboarding3.png',
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: List.generate(3, (index) => buildDot(index, context)),
              ),
              SizedBox(width: 220.w),
              Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff0961F5),
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    if (Provider.of<OnBoardingProvider>(context, listen: false)
                            .currentPage <
                        2) {
                      Provider.of<OnBoardingProvider>(context, listen: false)
                          .pageController
                          .nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                    } else {
                      Navigator.pushNamed(context, LetsYouInScreen.routeName);
                    }
                  },
                  icon: Icon(Icons.arrow_forward, size: 34),
                ),
              ),
            ],
          ),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    final currentPage = Provider.of<OnBoardingProvider>(context).currentPage;

    return Container(
      height: 10.h,
      width: 10.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? Color(0xff0961F5) : Color(0xffD8D8D8),
      ),
    );
  }
}
