
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_style.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../../core/widgets/custom_text_form_filed.dart';
import '../../../sign_up/presentation/screens/sign_up_screen.dart';
import '../../../widget/custom_circle_avatar.dart';
import '../../data/sign_in_view_model.dart';

class SignInScreen extends StatelessWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static const routeName = 'signIn';
  final SignInViewModel _viewModel = SignInViewModel();

  SignInScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Center(child: Image.asset('assets/telead_logo_vertical.png')),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'Let\'s Sign In.!',
                  style: AppStyles.style24(context),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Login to Your Account to Continue your Courses',
                  style: AppStyles.styleGray14(context),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextFormField(
                    title: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: emailController,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    obscureText: false),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    title: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    isSuffixIconShown: true,
                    isPassword: true,
                    obscureText: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'forget password?',
                          style: AppStyles.styleGray14(context),
                        ))
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomTextButton(
                    title: 'Sign In',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await _viewModel.signIn(
                            context,
                            emailController.text.trim(),
                            passwordController.text.trim());
                      }
                    }),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextButton(
                    title: 'Sign Out',
                    onPressed: () async {
                      showDialog<void>(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff0961F5),
                              ),
                            );
                          });
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Text(
                    'Or Continue With',
                    style: AppStyles.styleGray14(context),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleAvatar(image_title: 'assets/google_logo.png'),
                    SizedBox(
                      width: 20.w,
                    ),
                    CustomCircleAvatar(image_title: 'assets/facebook_logo.png'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
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
                            color: const Color(0xff0961F5),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
