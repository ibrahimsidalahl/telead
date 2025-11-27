import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';
import '../../../home/data/models/course_model.dart';

import '../manger/book_mark_cubit.dart';
import '../manger/book_mark_state.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F9FF),
        title: Text(
          'Bookmark',
          style: AppStyles.style24(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            if (state is BookmarkLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookmarkLoaded) {
              final List<CourseModel> courses = state.courses;

              if (courses.isEmpty) {
                return const Center(child: Text('لا يوجد كورسات محفوظة.'));
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];

                  return Stack(
                    children: [
                      Container(
                        height: 100.h,
                        margin: EdgeInsets.only(bottom: 10.h),
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
                                  image: NetworkImage(course.imageUrl ?? ''),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r),
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
                                    course.categoryId ?? '',
                                    style: TextStyle(
                                      color: const Color(0xffFF6B00),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    course.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Color(0xffFAC025)),
                                      Text(
                                          '${course.rating.length ?? 0.0}   | '),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 260,
                        bottom: 72,
                        child: IconButton(
                          onPressed: () {
                            // TODO: handle remove bookmark
                          },
                          icon: Icon(
                            Icons.bookmark,
                            size: 22.sp,
                            color: const Color(0xff0961F5),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (state is BookmarkError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox(); // Default case
          },
        ),
      ),
    );
  }
}
