import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:telead/features/bottom_navigation_bar/presentation/screens/bottom_navigation_bar_screen.dart';
import 'package:telead/features/home/presentation/screens/home_screen.dart';
import 'package:telead/features/on_boarding/presentation/widget/on_boarding_screen_body.dart';

import '../../../../core/styles/app_style.dart';
import '../../widget/custom_text_button.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';

import '../cubit/auth_state.dart';
import 'sign_up_screen.dart';
import '../../widget/custom_circle_avatar.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'signIn';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated && state.source == "signIn") {
              emailController.clear();
              passwordController.clear();
              final user = state.user;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                content: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xff0961F5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff0961F5).withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: Colors.white, size: 26),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Welcome back,${user.firstName}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
              // الانتقال لصفحة البروفايل
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarScreen(
                          fristName: user.firstName,
                          secondName: user.secondName,
                          phoneNumber: user.phone,
                          email: user.email,
                      userImage: user.userImage,
                        )),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(4),
                  content: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.white, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.message,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80.h),
                    Center(
                      child: Image.asset('assets/telead_logo_vertical.png'),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Let\'s Sign In.!',
                      style: AppStyles.style24(context),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Login to Your Account to Continue your Courses',
                      style: AppStyles.styleGray14(context),
                    ),
                    SizedBox(height: 24.h),

                    /// Email
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
                      obscureText: false,
                    ),
                    SizedBox(height: 20.h),

                    /// Password
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
                      obscureText: true, // الباسورد يبقى مخفي
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget password?',
                          style: AppStyles.styleGray14(context),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    /// Sign In button
                    CustomTextButton(
                      title: 'Sign In',
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signIn(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    /// Divider text
                    Center(
                      child: Text(
                        'Or Continue With',
                        style: AppStyles.styleGray14(context),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    /// Social sign in
                    CustomCircleAvatar(image_title: 'assets/google_logo.png'),
                    SizedBox(height: 20.h),

                    /// Sign up redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an Account ?',
                          style: AppStyles.styleGray14(context),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignUpScreen.routeName);
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0961F5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
