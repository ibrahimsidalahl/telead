
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bookmark/presentation/screens/book_mark_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../my_courses/presentation/screens/my_courses_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../manger/bottom_navigation_provider.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final String user_id;

  BottomNavigationBarScreen({super.key, required this.user_id});

  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationProvider = context.watch<BottomNavigationProvider>();

    int selectedIndex = bottomNavigationProvider.selectedIndex;

    final List<Widget> _pages = [
      HomeScreen(user_id: widget.user_id),
      const MyCoursesScreen(),
      const BookMarkScreen(),
      ProfileScreen(user_id: widget.user_id),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      body: _pages[selectedIndex],  // Accessing the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: selectedIndex,  // Use the selected index from the provider
        onTap: (index) {
          bottomNavigationProvider.onItemTapped(index);
        },
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
  }
}
