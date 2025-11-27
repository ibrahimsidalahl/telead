// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../../../../core/firebase_services/book_mark_services.dart';
// import '../../../../core/widgets/custom_search_bar.dart';
// import '../../../../core/styles/app_style.dart';
//
// import '../../data/models/rating_model.dart';
// import '../manger/course_cubit/course_cubit.dart';
// import '../manger/course_cubit/course_state.dart';
// import 'course_details_screen.dart';
//
// class CategoryDetailsScreen extends StatelessWidget {
//   final String id;
//
//   const CategoryDetailsScreen({super.key, required this.id});
//
//   static const routeName = 'categoryDetails';
//
//   double getAverageRating(List<Rating> ratings) {
//     if (ratings.isEmpty) return 0.0;
//     double total = ratings.fold(0, (sum, r) => sum + r.rate);
//     return total / ratings.length;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CourseCubit()..fetchCategories(id),
//       child: Scaffold(
//         backgroundColor: const Color(0xffF5F9FF),
//         appBar: AppBar(
//           backgroundColor: const Color(0xffF5F9FF),
//           title: Text('All Courses', style: AppStyles.style24(context)),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, size: 24.sp),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             children: [
//               SizedBox(height: 20.h),
//               CustomSearchBar(),
//               SizedBox(height: 20.h),
//               Expanded(
//                 child: BlocBuilder<CourseCubit, CourseState>(
//                   builder: (context, state) {
//                     if (state is CourseLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is CourseLoaded) {
//                       final courses = state.course;
//
//                       if (courses.isEmpty) {
//                         return const Center(
//                           child: Text(
//                             'No courses found',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         );
//                       }
//
//                       return ListView.builder(
//                         itemCount: courses.length,
//                         itemBuilder: (context, index) {
//                           final course = courses[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CourseDetailsScreen(
//                                     title: course.title,
//                                     category_Id: course.categoryId,
//                                     description: course.description,
//                                     image_Url: course.imageUrl,
//                                     instructor_Id: course.instructorId,
//                                     price: course.price,
//                                     rating: course.rating,
//                                     lessons: course.lessons,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Stack(
//                               children: [
//                                 Container(
//                                   height: 120.h,
//                                   width: 360.w,
//                                   margin: EdgeInsets.symmetric(vertical: 8.h),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(8.r),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         spreadRadius: 5,
//                                         blurRadius: 7,
//                                         offset: const Offset(0, 3),
//                                       )
//                                     ],
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         height: 140.h,
//                                         width: 120.w,
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image:
//                                             NetworkImage(course.imageUrl),
//                                             fit: BoxFit.fill,
//                                           ),
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(8.r),
//                                             bottomLeft: Radius.circular(8.r),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10.w),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(height: 8.h),
//                                           Text(
//                                             '3D Design',
//                                             style: AppStyles.styleOrange16(
//                                                 context),
//                                           ),
//                                           SizedBox(height: 2.h),
//                                           SizedBox(
//                                             width: 188.w,
//                                             child: Text(
//                                               course.title,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: AppStyles.styleBold20(
//                                                   context),
//                                             ),
//                                           ),
//                                           SizedBox(height: 2.h),
//                                           Text(
//                                             '${course.price} \$',
//                                             style: TextStyle(
//                                               color: Color(0xff0961F5),
//                                               fontSize: 18.sp,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(height: 2.h),
//                                           Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.star,
//                                                 color: Colors.yellow,
//                                                 size: 16.sp,
//                                               ),
//                                               Text(
//                                                 getAverageRating(course.rating).toStringAsFixed(1),
//                                                 style: TextStyle(
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 '    |   ${course.studentEnrolled.length} Std',
//                                                 style: TextStyle(
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 94.h,
//                                   right: 1.w,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.book_outlined,
//                                       color: Colors.blue,
//                                       size: 28.sp,
//                                     ),
//                                     onPressed: () async {
//                                       final userId = FirebaseAuth
//                                           .instance.currentUser!.uid;
//                                       final coursePath =
//                                           'categories/${course.categoryId}/courses/${course.id}';
//                                       await BookMarkServices(userId)
//                                           .addBookmark(coursePath);
//
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text(
//                                                 'Course added to bookmarks')),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else if (state is CourseError) {
//                       return Center(child: Text(state.message));
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
