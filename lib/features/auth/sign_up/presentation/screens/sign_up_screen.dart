import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_style.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../bottom_navigation_bar/presentation/screens/bottom_navigation_bar_screen.dart';
import '../../../../home/presentation/screens/teacher.dart';
import '../../../sign_in/presentation/screens/sign_in_screen.dart';
import '../../../widget/custom_circle_avatar.dart';

class SignUpScreen extends StatefulWidget {
  static TextEditingController fristNameController = TextEditingController();
  static TextEditingController secondNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();
  static const routeName = 'signUp';

  SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedRole = 'Student';

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
                  height: 60.h,
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
                      setState(() {
                        selectedRole = newValue!;
                      });
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

                        showDialog<void>(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff0961F5),
                                ),
                              );
                            });

                        try {

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(SignUpScreen.emailController.text.trim())
                              .set({
                            'frist_name': SignUpScreen.fristNameController.text.trim(),
                            'second_name':
                            SignUpScreen.secondNameController.text.trim(),
                            'email': SignUpScreen.emailController.text.trim(),
                            'phone': SignUpScreen.phoneController.text.trim(),
                            'role': selectedRole,
                          });

                          final UserCredential userCredential =
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                            email: SignUpScreen.emailController.text.trim(),
                            password: SignUpScreen.passwordController.text.trim(),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Succes!'),
                              backgroundColor: Color(0xff0961F5),
                            ),
                          );
                          if (selectedRole == 'Student') {
                            print('user is student');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationBarScreen(
                                    user_id:
                                        '${SignUpScreen.emailController.text.trim()}'),
                              ),
                            );
                          } else if (selectedRole == 'Teacher') {
                            print('user is teacher');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Teacher(),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            Navigator.of(context).pop();

                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'The account already exists for that email.'),
                                backgroundColor: Color(0xff0961F5),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('An unexpected error occurred.'),
                                backgroundColor: Color(0xff0961F5),
                              ),
                            );
                            print('An unexpected error occurred: $e');
                          }
                        } catch (e) {
                          Navigator.of(context).pop();

                          print('Error: $e');
                        }
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
