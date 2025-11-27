import 'package:flutter/material.dart';
import 'on_boarding_view_component.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        OnboardingViewComponent(
          title: 'Online Learning',
          subTitle: 'We Provide Online Classes and Pre Recorded Lectures.!',
          image: 'assets/onboarding1.png',
          isVisible: true,
        ),
        OnboardingViewComponent(
          title: 'Learn from Anytime',
          subTitle: 'Booked or Save the Lectures for Future',
          image: 'assets/onboarding2.png',
          isVisible: true,
        ),
        OnboardingViewComponent(
          title: 'Get Online Certificate',
          subTitle: 'Analyze your scores and Track your results',
          image: 'assets/onboarding3.png',
          isVisible: false,
        )
      ],
    );
  }
}
