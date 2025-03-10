import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telead/features/home/data/models/lessons_model.dart';
import 'package:telead/features/home/presentation/screens/lessons_screen.dart';
import 'package:telead/features/home/presentation/widgets/course_details_box.dart';
import 'package:telead/features/home/presentation/widgets/reviews_list_view.dart';

import '../../../profile/presentation/manger/user_provider.dart';
import '../../data/models/rating_model.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String title;
  final String instructor_Id;
  final String image_Url;
  final String description;
  final String category_Id;
  final num price;
  final List<Rating> rating;
  final List<LessonsModel> lessons;

  const CourseDetailsScreen({
    required this.rating,
    required this.title,
    required this.instructor_Id,
    required this.image_Url,
    required this.description,
    required this.category_Id,
    required this.price,
    required this.lessons,
    super.key,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late Future<void> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = Provider.of<UsersProvider>(context, listen: false)
        .fetchUserData(widget.instructor_Id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image_Url),
                    ),
                  ),
                ),
                SizedBox(height: 220.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Instructor',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder(
                        future: _userFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Text('Error loading instructor data');
                          } else {
                            final user = Provider.of<UsersProvider>(context,
                                    listen: false)
                                .user;
                            if (user == null) {
                              return const Text(
                                  'Instructor data not available');
                            }
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    radius: 28.r,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        NetworkImage(user.user_image!),
                                  ),
                                  title: Text(
                                      '${user.first_name} ${user.second_name}'),
                                  subtitle: Text(user.job_title!),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Reviews',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ReviewsListView(rating: widget.rating),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 12.h,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: const Color(0xff0961F5),
                  size: 24.sp,
                ),
              ),
            ),
            Positioned(
              top: 290.h,
              left: 30.w,
              child: CourseDetailsBox(
                title: widget.title,
                rating: widget.rating,
                category_id: widget.category_Id,
                price: widget.price,
                description: widget.description,
                lessons: widget.lessons,
              ),
            ),
            Positioned(
              right: 40.w,
              top: 280.h,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff167F71),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(90, 90)),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LessonsScreen(lessons: widget.lessons),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.play_circle_outline_outlined,
                    size: 30.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
