//
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../auth/data/user_model.dart';
// import '../../../profile/presentation/manger/user_provider.dart';
// import '../../data/models/rating_model.dart';
// import '../manger/toggle.dart';
//
// class CourseDetailsScreen extends StatefulWidget {
//   final String title;
//   final String instructor_Id;
//   final String image_Url;
//   final String description;
//   final String category_Id;
//   final num price;
//   final List<Rating> rating;
//
//   const CourseDetailsScreen({
//     required this.rating,
//     required this.title,
//     required this.instructor_Id,
//     required this.image_Url,
//     required this.description,
//     required this.category_Id,
//     required this.price,
//     super.key,
//   });
//
//   @override
//   State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
// }
//
// class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       Provider.of<UsersProvider>(context, listen: false)
//           .fetchUserData(widget.instructor_Id);
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = context.watch<UsersProvider>();
//     final user = userProvider.user;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 300.h,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(widget.image_Url))),
//               ),
//               SizedBox(
//                 height: 220.h,
//               ),
//               Container(
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Instructor',
//                             style: TextStyle(
//                                 fontSize: 18.sp, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10.r),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 3,
//                                   blurRadius: 5,
//                                   offset: const Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 // Removes the padding
//                                 leading: CircleAvatar(
//                                   radius: 28.r,
//                                   backgroundColor: Colors.white,
//                                   backgroundImage:
//                                   NetworkImage('${user!.user_image}'),
//                                 ),
//                                 title: Text(
//                                     '${user?.first_name} ${user?.second_name}'),
//                                 subtitle: Text('${user.job_title}'),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 14,
//                           ),
//                           Text(
//                             'Reviews',
//                             style: TextStyle(
//                                 fontSize: 18.sp, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 8,
//                           ),
//                           // Container(
//                           //     height: 100 * widget.rating.length.toDouble(),
//                           //     child: ListView.builder(
//                           //       itemCount: widget.rating.length,
//                           //       itemBuilder: (BuildContext context, int index) {
//                           //         final rating = widget.rating[index];
//                           //
//                           //         return FutureBuilder<UserModel?>(
//                           //           future: Provider.of<UsersProvider>(context, listen: false)
//                           //               .fetchUserData(rating.user_id), // Fetch user data for each rating's user_id
//                           //           builder: (context, snapshot) {
//                           //             if (snapshot.connectionState == ConnectionState.waiting) {
//                           //               return const Center(child: CircularProgressIndicator());
//                           //             }
//                           //
//                           //             if (snapshot.hasError) {
//                           //               return const Text('Error fetching user data');
//                           //             }
//                           //
//                           //             final user = snapshot.data;
//                           //
//                           //             return Column(
//                           //               children: [
//                           //                 Container(
//                           //                   decoration: BoxDecoration(
//                           //                     color: Colors.white,
//                           //                     borderRadius: BorderRadius.circular(10.r),
//                           //                     boxShadow: [
//                           //                       BoxShadow(
//                           //                         color: Colors.grey.withOpacity(0.3),
//                           //                         spreadRadius: 3,
//                           //                         blurRadius: 5,
//                           //                         offset: const Offset(0, 3),
//                           //                       ),
//                           //                     ],
//                           //                   ),
//                           //                   child: ListTile(
//                           //                     leading: CircleAvatar(
//                           //                       radius: 28.r,
//                           //                       backgroundColor: Colors.white,
//                           //                       backgroundImage: user?.user_image != null
//                           //                           ? NetworkImage(user!.user_image!)
//                           //                           : const AssetImage('assets/images/default_avatar.png')
//                           //                       as ImageProvider, // Default image if no user image
//                           //                     ),
//                           //                     title: Row(
//                           //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //                       children: [
//                           //                         Container(
//                           //                           width: 196.w,
//                           //                           child: Text(
//                           //                             user != null
//                           //                                 ? '${user.first_name} ${user.second_name}' // User's name
//                           //                                 : 'Anonymous', // Fallback name
//                           //                             style: TextStyle(
//                           //                               fontSize: 16.sp,
//                           //                               fontWeight: FontWeight.bold,
//                           //                               color: Colors.black,
//                           //                               overflow: TextOverflow.ellipsis,
//                           //                             ),
//                           //                           ),
//                           //                         ),
//                           //                         Container(
//                           //                           padding: EdgeInsets.symmetric(
//                           //                               horizontal: 8.w, vertical: 4.h),
//                           //                           decoration: BoxDecoration(
//                           //                             color: Colors.blue[50],
//                           //                             borderRadius: BorderRadius.circular(20.r),
//                           //                           ),
//                           //                           child: Row(
//                           //                             children: [
//                           //                               Icon(
//                           //                                 Icons.star,
//                           //                                 color: Colors.amber,
//                           //                                 size: 16.sp,
//                           //                               ),
//                           //                               SizedBox(width: 4.w),
//                           //                               Text(
//                           //                                 '${rating.rate}',
//                           //                                 style: TextStyle(
//                           //                                   fontSize: 14.sp,
//                           //                                   fontWeight: FontWeight.bold,
//                           //                                   color: Colors.blue,
//                           //                                 ),
//                           //                               ),
//                           //                             ],
//                           //                           ),
//                           //                         ),
//                           //                       ],
//                           //                     ),
//                           //                     subtitle: Column(
//                           //                       crossAxisAlignment: CrossAxisAlignment.start,
//                           //                       children: [
//                           //                         SizedBox(height: 4.h),
//                           //                         Text(
//                           //                           rating.comment,
//                           //                           style: TextStyle(
//                           //                             fontSize: 14.sp,
//                           //                             color: Colors.grey[700],
//                           //                           ),
//                           //                         ),
//                           //                       ],
//                           //                     ),
//                           //                     contentPadding: EdgeInsets.all(12.w),
//                           //                   ),
//                           //                 ),
//                           //                 SizedBox(
//                           //                   height: 14.h,
//                           //                 )
//                           //               ],
//                           //             );
//                           //           },
//                           //         );
//                           //       },
//                           //     ),
//                           // ),
//                           SizedBox(
//                             height: 12,
//                           )
//                         ],
//                       ),
//                     )),
//               )
//             ],
//           ),
//           Positioned(
//               top: 12.h,
//               child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: const Color(0xff0961F5),
//                     size: 24.sp,
//                   ))),
//           Positioned(
//             top: 290.h,
//             left: 30.w,
//             child: Container(
//               width: 300.w, // Adjust the width to fit the content
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 3,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.category_Id,
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                             size: 14.sp,
//                           ),
//                           SizedBox(width: 4.w),
//                           Text(
//                             '4.2',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//
//                   // Course title
//                   Text(
//                     widget.title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.sp,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: 8.h),
//
//                   // Class and hours info
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.people,
//                         size: 14.sp,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(width: 4.w),
//                       Text(
//                         '21 Class',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(width: 16.w),
//                       Icon(
//                         Icons.access_time,
//                         size: 14.sp,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(width: 4.w),
//                       Text(
//                         '42 Hours',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//
//                   // Price tag
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       '\$${widget.price}',
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//
//                   // Tab bar
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: (){
//
//                             Provider.of<ToggleProvider>(context, listen: false).toggleColors();
//                           },
//                           child: Expanded(
//                             child: Container(
//                               width: 140.w,
//                               padding: EdgeInsets.symmetric(vertical: 8.h),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 color:       Provider.of<ToggleProvider>(context, listen: false).activeColor1
//                                 ,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'About',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//
//                             Provider.of<ToggleProvider>(context, listen: false).toggleColors();
//                           },
//                           child: Expanded(
//                             child: Container(
//                               width: 128.w,
//                               padding: EdgeInsets.symmetric(vertical: 8.h),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 color: Provider.of<ToggleProvider>(context, listen: false).activeColor2,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Curriculum',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//
//                   // Description with Read More
//                   Text(
//                     widget.description,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Colors.grey[700],
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             right: 40.w,
//             top: 280.h,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xff167F71),
//                 border: Border.all(color: Colors.black, width: 0.0),
//                 borderRadius: const BorderRadius.all(Radius.elliptical(90, 90)),
//               ),
//               child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.play_circle_outline_outlined,
//                     size: 30.sp,
//                     color: Colors.white,
//                   )),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
