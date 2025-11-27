import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';
import 'package:telead/features/home/presentation/screens/home_screen.dart';

import '../../widget/custom_text_button.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'sign_in_screen.dart';
import '../../widget/custom_circle_avatar.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signUp';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated && state.source == "signUp") {
                firstNameController.clear();
                secondNameController.clear();
                emailController.clear();
                passwordController.clear();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  content: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                        const Expanded(
                          child: Text(
                            'Account created! Please log in...',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(16),
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
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      Center(
                        child: Image.asset('assets/telead_logo_vertical.png'),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        'Getting Started.!',
                        style: AppStyles.style24(context),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Create an Account to Continue your Courses',
                        style: AppStyles.styleGray14(context),
                      ),
                      SizedBox(height: 24.h),

                      /// First Name
                      CustomTextFormField(
                        title: 'First Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        controller: firstNameController,
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 24.h),

                      /// Second Name
                      CustomTextFormField(
                        title: 'Second Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your second name';
                          }
                          return null;
                        },
                        controller: secondNameController,
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 20.h),

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
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 20.h),

                      /// Phone
                      CustomTextFormField(
                        title: 'Phone',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
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
                        isPassword: true,
                        isSuffixIconShown: true,
                        obscureText: true,
                      ),
                      SizedBox(height: 20.h),

                      /// Confirm Password
                      CustomTextFormField(
                        title: 'Confirm Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        isPassword: true,
                        isSuffixIconShown: true,
                        obscureText: true,
                      ),
                      SizedBox(height: 24.h),

                      /// Sign Up button
                      CustomTextButton(
                        title: 'Sign Up',
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signUpWithData(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  firstName: firstNameController.text.trim(),
                                  secondName: secondNameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                );
                            context.read<AuthCubit>().signOut();
                          }
                        },
                      ),
                      SizedBox(height: 12.h),

                      Center(
                        child: Text(
                          'Or Continue With',
                          style: AppStyles.styleGray14(context),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomCircleAvatar(
                              image_title: 'assets/google_logo.png'),
                          SizedBox(width: 20.w),
                          CustomCircleAvatar(
                              image_title: 'assets/facebook_logo.png'),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an Account ?',
                            style: AppStyles.styleGray14(context),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                            child: Text(
                              'SIGN IN',
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
      ),
    );
  }
}
