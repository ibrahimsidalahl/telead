import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telead/core/widgets/custom_list_tile.dart';
import 'package:telead/features/profile/presentation/widgets/custom_arrow_forward.dart';
import 'package:telead/features/profile/presentation/widgets/custom_avatar.dart';

import '../../../../core/styles/app_style.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../manger/theme_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthCubit>().currentUser;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Profile',
            style: AppStyles.style24(context),
          ),
          actions: [
            IconButton(
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
                            const Icon(Icons.logout,
                                color: Colors.white, size: 26),
                            // 🔹 Changed icon
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'You have signed out successfully.',
                                // 🔹 Updated text
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ))
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            backgroundColor: Colors.white,
            color: const Color(0xff0961F5),
            onRefresh: () async {
              context.read<AuthCubit>().loadCurrentUser();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Stack(children: [
                Column(
                  children: [
                    SizedBox(height: 100.h),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            width: 320.w,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  SizedBox(height: 40.h),
                                  // Space for the avatar
                                  Text(
                                    '${user!.firstName} ${user.secondName}',
                                    style: AppStyles.style24(context),
                                  ),
                                  Text(
                                    user.email,
                                    style: AppStyles.style20(context),
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.person_2_outlined,
                                      size: 26.sp,
                                    ),
                                    title: 'Edit Profile',
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileScreen(
                                                      email: user.email,
                                                      fristName: user.firstName,
                                                      phone: user.phone,
                                                      secondName:
                                                          user.secondName,
                                                      url: ''),
                                            ));
                                      },
                                      icon: const CustomArrowForward(),
                                    ),
                                  ),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.payment,
                                      size: 26.sp,
                                    ),
                                    title: 'Payment Option',
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const CustomArrowForward(),
                                    ),
                                  ),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.notifications_none,
                                      size: 26.sp,
                                    ),
                                    title: 'Notifications',
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const CustomArrowForward(),
                                    ),
                                  ),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.security,
                                      size: 26.sp,
                                    ),
                                    title: 'Security',
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const CustomArrowForward(),
                                    ),
                                  ),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.language,
                                      size: 26.sp,
                                    ),
                                    title: 'Language',
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const CustomArrowForward(),
                                    ),
                                  ),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 26.sp,
                                    ),
                                    title: 'Dark Mode',
                                    trailing: Switch(
                                      activeColor: const Color(0xff0961F5),
                                      value: Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .switchActive,
                                      onChanged: (bool value) {
                                        Provider.of<ThemeProvider>(context,
                                                listen: false)
                                            .toggleMode();
                                      },
                                    ),
                                  ),
                                  CustomListTile(
                                    leading: Icon(
                                      Icons.help_outline,
                                      size: 26.sp,
                                    ),
                                    title: 'Help Center',
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const CustomArrowForward(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                    heightFactor: 1.19,
                    child: CustomAvatar(
                      url: user.userImage,
                    )),
              ]),
            ),
          ),
        ));
  }
}
