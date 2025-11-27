import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';
import '../../../auth/widget/custom_text_button.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';
import '../widget/signIn_with_widget.dart';

class LetsYouInScreen extends StatelessWidget {
  static const routeName = 'letsYouIn';

  const LetsYouInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 280.h,
              ),
              Text(
                'Let’s you in',
                textAlign: TextAlign.center,
                style: AppStyles.style24(context),
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 100.h,
                width: 220.w,
                child: Column(
                  children: [
                    SigninWithWidget(
                        title: 'Continue with Google',
                        image: 'assets/google_logo.png'),
                    SizedBox(
                      height: 12.h,
                    ),
                    SigninWithWidget(
                        title: 'Continue with Facebook',
                        image: 'assets/facebook_logo.png')
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text('(or)' , textAlign: TextAlign.center,
                style: AppStyles.style24(context),),
              SizedBox(
                height: 16.h,
              ),

              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account ?',
                    style: AppStyles.styleGray14(context),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0961F5),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
