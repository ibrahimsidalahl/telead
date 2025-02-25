
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telead/core/widgets/custom_search_bar.dart';
import 'package:telead/features/home/presentation/manger/courses_provider.dart';

import '../../../../core/styles/app_style.dart';
import 'course_details_screen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String id;

  CategoryDetailsScreen({required this.id, super.key});

  static const routeName = 'categoryDetails';

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoursesProvider>(context, listen: false).fetchData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = context.watch<CoursesProvider>();
    final courses = courseProvider.courses;

    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F9FF),
        title: Text(
          'All Courses',
          style: AppStyles.style24(context),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomSearchBar(),
            SizedBox(height: 20.h),
            Expanded(
              child: courses != null
                  ? ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailsScreen(
                                  title: course.title,
                                  category_Id: course.categoryId,
                                  description: course.description,
                                  image_Url: course.imageUrl,
                                  instructor_Id: course.instructorId,
                                  price: course.price,
                                  rating: course.rating,
                                ),
                              ),
                            );
                            print(course.rating);
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 120.h,
                                width: 360.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      )
                                    ]),
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 140.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(course.imageUrl),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.r),
                                            bottomLeft: Radius.circular(8.r)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.h),
                                        Text(
                                          '3D Design',
                                          style:
                                              AppStyles.styleOrange16(context),
                                        ),
                                        SizedBox(height: 2.h),
                                        Container(
                                          width: 188.w,
                                          child: Text(
                                            course.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.styleBold20(context),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          '${course.price} \$',
                                          style: TextStyle(
                                              color: Color(0xff0961F5),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 2.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 16.sp,
                                            ),
                                            Text(
                                              '${course.rating[0].rate}',
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '    |   ${course.studentEnrolled.length} Std',
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 94.h,
                                right: 1.w,
                                child: IconButton(
                                  onPressed: () {
                                    // Add your onPressed logic here
                                  },
                                  icon: Icon(
                                    Icons.book_outlined,
                                    color: Colors.blue,
                                    size: 28.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
