import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../../my_courses/presentation/screens/my_courses_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../manger/bottom_navigation_cubit.dart';
import '../manger/bottom_navigation_state.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  String fristName;
  String secondName;
  String email;
  String phoneNumber;
  String userImage;

  BottomNavigationBarScreen(
      {super.key,
      required this.fristName,
      required this.secondName,
      required this.email,
      required this.phoneNumber,
      required this.userImage});

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(),
      const MyCoursesScreen(),
      const MyCoursesScreen(),
      ProfileScreen(),
    ];
    return BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, navState) {
      return Scaffold(
        backgroundColor: const Color(0xffF5F9FF),
        body: pages[navState.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.cyan,
          currentIndex: navState.selectedIndex,
          onTap: (index) => context.read<BottomNavCubit>().onItemTapped(index),
          selectedItemColor: const Color(0xff0961F5),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'My Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }
}
