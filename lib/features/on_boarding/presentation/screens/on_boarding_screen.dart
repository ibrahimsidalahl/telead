import 'package:flutter/material.dart';
import 'package:telead/features/on_boarding/presentation/widget/on_boarding_screen_body.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  static const routeName = '/onBoarding';

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: SafeArea(child: OnBoardingScreenBody()),
    );
  }
}