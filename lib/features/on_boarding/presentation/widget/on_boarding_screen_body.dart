import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/features/on_boarding/presentation/widget/custom_forward_button.dart';
import 'package:telead/features/on_boarding/presentation/widget/on_boarding_page_view.dart';

class OnBoardingScreenBody extends StatefulWidget {
  const OnBoardingScreenBody({super.key});

  @override
  State<OnBoardingScreenBody> createState() => _OnBoardingScreenBodyState();
}

class _OnBoardingScreenBodyState extends State<OnBoardingScreenBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Column(
        children: [
          Expanded(
              child: OnBoardingPageView(
            pageController: pageController,
          )),
          DotsIndicator(
            dotsCount: 3,
            position: currentPage.toDouble(),
            animationDuration: Duration(milliseconds: 500),
            animate: true,
            decorator: DotsDecorator(
              activeColor: Color(0xff0961F5),
              color: Color(0xffD5E2F5),
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          SizedBox(
            height: 120.h,
          ),

        ],
      ),

      Visibility(
        visible: currentPage == 2,
        child: Positioned(
            right: 20.w,
            bottom: 20.h,

            child: CustomForwardButton()),
      )

      ]
    );
  }
}
