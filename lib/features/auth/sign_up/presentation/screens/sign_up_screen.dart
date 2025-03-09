
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/app_style.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../../core/widgets/custom_text_form_filed.dart';
import '../../../sign_in/presentation/screens/sign_in_screen.dart';
import '../../../widget/custom_circle_avatar.dart';
import '../../data/sign_up_view_model.dart';
import '../manger/sign_up_provider.dart';

class SignUpScreen extends StatelessWidget  {
  static TextEditingController fristNameController = TextEditingController();
  static TextEditingController secondNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();
  final SignUpViewModel _viewModel = SignUpViewModel();
  static const routeName = 'signUp';

  SignUpScreen({super.key});


  String selectedRole = 'Student';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpProvider>(context);

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
                  'Getting Started.!',
                  style: AppStyles.style24(context),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Create an Account to Continue your allCourses',
                  style: AppStyles.styleGray14(context),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextFormField(
                    title: 'Frist Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: SignUpScreen.fristNameController,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    obscureText: false),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextFormField(
                    title: 'Second Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your second name';
                      }
                      return null;
                    },
                    controller: SignUpScreen.secondNameController,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    obscureText: false),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                    title: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: SignUpScreen.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    obscureText: false),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                    title: 'Phone',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    controller: SignUpScreen.phoneController,
                    prefixIcon: Icon(
                      Icons.phone_android_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    obscureText: false),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                    title: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: SignUpScreen.passwordController,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    isPassword: true,
                    isSuffixIconShown: true,
                    obscureText: true),
                SizedBox(
                  height: 20.h,
                ),

                CustomTextFormField(
                    title: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                    controller: SignUpScreen.confirmPasswordController,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    isPassword: true,
                    isSuffixIconShown: true,
                    obscureText: true),
                SizedBox(
                  height: 24.h,
                ),
                // Dropdown for role selection
                Material(
                  elevation: 4,
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: InputDecoration(
                        labelText: 'Select Role',
                        labelStyle: TextStyle(
                          color: const Color(0xff0961F5),
                          fontSize: 16.sp,
                        ),
                        prefixIcon: Icon(Icons.school_outlined,
                            color: Theme.of(context).primaryColor),
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            )),
                        hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    items: ['Student', 'Teacher'].map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      viewModel.setSelectedRole(newValue!);
                    },
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextButton(
                    title: 'Sign Up',
                    onPressed: () async {

                      if (formKey.currentState!.validate()) {
                        await _viewModel.signUp(
                          context,
                          fristNameController.text,
                          secondNameController.text,
                          emailController.text,
                          phoneController.text,
                          passwordController.text,
                          selectedRole,
                        );
                      }
                    }),
                SizedBox(
                  height: 12.h,
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
                      'Already have an Account ?',
                      style: AppStyles.styleGray14(context),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0961F5),
                          ),
                        ))
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
