import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../home/data/models/rating_model.dart';
import '../cubit/my_courses_cubit.dart';
import '../cubit/my_courses_states.dart';
import '../../../../features/home/data/models/course_model.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  static const routeName = 'myCourses';

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'My Courses',
          style: AppStyles.style24(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CustomSearchBar(),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<MyCoursesCubit, MyCoursesState>(
                builder: (context, state) {
                  if (state is MyCoursesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MyCoursesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is MyCoursesLoaded) {
                    final courses = state.courses;
                    if (courses.isEmpty) {
                      return const Center(child: Text("No courses found"));
                    }
                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 3,
                      ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return _CourseCard(course: course);
                      },
                    );
                  }
                  return const Center(child: Text("Press refresh to load courses"));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<MyCoursesCubit>().fetchMyCourses();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final CourseModel course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    double getAverageRating(List<Rating> ratings) {
      if (ratings.isEmpty) return 0.0;
      double total = ratings.fold(0, (sum, r) => sum + r.rate);
      return total / ratings.length;
    }
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(course.imageUrl ?? ""), // ← حسب الـ model
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      course.categoryId ?? "Unknown Category",
                      style: TextStyle(
                        color: const Color(0xffFF6B00),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      course.title ?? "No title",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xffFAC025)),
                        Text('${getAverageRating(course.rating).toStringAsFixed(1)}',),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 10.w,
          top: 10.h,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_border_outlined,
              size: 24.sp,
              color: const Color(0xff0961F5),
            ),
          ),
        )
      ],
    );
  }
}
