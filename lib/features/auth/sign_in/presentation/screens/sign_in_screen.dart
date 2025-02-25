import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/app_style.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../bottom_navigation_bar/presentation/screens/bottom_navigation_bar_screen.dart';
import '../../../../home/presentation/screens/teacher.dart';
import '../../../sign_up/presentation/screens/sign_up_screen.dart';
import '../../../widget/custom_circle_avatar.dart';

class SignInScreen extends StatefulWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static const routeName = 'signIn';

  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  height: 60.h,
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
                    controller: SignInScreen.emailController,
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
                    controller: SignInScreen.passwordController,
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
                        showDialog<void>(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(color: Color(0xff0961F5),),
                              );
                            });

                        try {

                          // Fetch the user's document from Firestore based on their email
                          DocumentSnapshot userDoc = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(SignInScreen.emailController.text.trim())
                              .get();

                          if (userDoc.exists) {
                            String role = userDoc['role'];

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Success!'),
                                backgroundColor: Color(0xff0961F5),
                              ),
                            );
                            // SignInScreen.emailController.clear();
                            // SignInScreen.passwordController.clear();
                            if (role == 'Student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationBarScreen(
                                    user_id: SignInScreen.emailController.text
                                        .trim(),
                                  ),
                                ),
                              );
                            } else if (role == 'Teacher') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Teacher(),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('User document not found!')),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('No user found for that email.')),
                            );
                          } else if (e.code == 'wrong-password') {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Wrong password provided.')),
                            );
                          } else if (e.code == 'invalid-credential') {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Invalid credential. Please try again.')),
                            );
                          } else {
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('An error occurred1: ${e.message}')),
                            );
                          }
                        } catch (e) {
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'An error occurred2: ${e.toString()}')),
                          );
                        }
                      }
                    }),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextButton(
                    title: 'Sign Out',
                    onPressed: () async {
                      showDialog<void>(
                          context:context,
                          builder : (context){
                            return const Center(child: CircularProgressIndicator(color: Color(0xff0961F5),),);
                          }
                      );
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
