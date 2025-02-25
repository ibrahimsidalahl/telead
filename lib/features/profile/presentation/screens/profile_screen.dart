
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telead/core/widgets/custom_list_tile.dart';
import 'package:telead/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:telead/features/profile/presentation/widgets/custom_arrow_forward.dart';
import 'package:telead/features/profile/presentation/widgets/custom_avatar.dart';

import '../../../../core/styles/app_style.dart';
import '../../../auth/sign_in/presentation/screens/sign_in_screen.dart';
import '../manger/theme_provider.dart';
import '../manger/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  String user_id;
   ProfileScreen({super.key, required this.user_id,});

  static const routeName = 'profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<UsersProvider>(context, listen: false)
            .fetchUserData(widget.user_id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UsersProvider>();
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F9FF),
        title: Text(
          'Profile',
          style: AppStyles.style24(context),
        ),
        actions: [
          IconButton(
              onPressed: () async {

                showDialog<void>(
                    context:context,
                    builder : (context){
                      return const Center(child: CircularProgressIndicator(color: Color(0xff0961F5),),);
                    }
                );
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sign out success!'),
                    backgroundColor: Color(0xff0961F5),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),


      body:
      user.user != null ?

      Stack(children: [
        Column(
          children: [
            SizedBox(height: 100.h),
            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    width: 320.w,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SizedBox(height: 40.h), // Space for the avatar
                          Text(
                            '${user.user!.first_name} ${user.user!.second_name}',
                            style: AppStyles.style24(context),
                          ),
                          Text(
                            user.user!.email,
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
                                      builder: (context) => EditProfileScreen(
                                          email: user.user!.email,
                                          frist_name:
                                              user.user!.first_name,
                                          phone: user.user!.phone,
                                          second_name:
                                              user.user!.second_name,
                                          url: '${user.user!.user_image}'),
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
            heightFactor: 1.4,
            child: CustomAvatar(url: '${user.user!.user_image}')),

      ]) : const Center(
    child: CircularProgressIndicator(color: Color(0xff0961F5),),
    ),
    );
  }
}
