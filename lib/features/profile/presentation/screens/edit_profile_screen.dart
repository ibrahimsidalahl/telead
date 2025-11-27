import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../widgets/custom_avatar.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({
    super.key,
    required this.url,
    required this.email,
    required this.secondName,
    required this.fristName,
    required this.phone,
  })  : fristNameController = TextEditingController(text: fristName),
        secondNameController = TextEditingController(text: secondName),
        emailController = TextEditingController(text: email),
        phoneController = TextEditingController(text: phone);

  late final String url;
  final String fristName;
  final String secondName;
  final String email;
  final String phone;
  File? imageFile;

  final TextEditingController fristNameController;
  final TextEditingController secondNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  static const routeName = 'edit profile';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Edit Profile',
          style: AppStyles.style24(context),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Stack(children: [
                Center(
                    child: CustomAvatar(
                  url: url,
                )),
                Positioned(
                    right: 90.w,
                    bottom: 10.h,
                    child: CircleAvatar(
                      backgroundColor: Colors.white60,
                      child: IconButton(

                          onPressed: () {},
                          icon: Icon(

                            Icons.camera_alt_outlined,
                            color: const Color(0xff0961F5),
                            size: 24.sp,
                          )),
                    ))
              ]),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                  title: 'Frist name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: fristNameController,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  obscureText: false),
              SizedBox(
                height: 8.h,
              ),
              CustomTextFormField(
                  title: 'Second name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: secondNameController,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  obscureText: false),
              SizedBox(
                height: 8.h,
              ),

              CustomTextFormField(
                  title: 'Phone',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  controller: phoneController,
                  prefixIcon: Icon(
                    Icons.phone_android_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  obscureText: false),
              SizedBox(
                height: 10.h,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
