import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/features/home/data/models/lessons_model.dart';

import '../../data/models/rating_model.dart';

class CourseDetailsBox extends StatelessWidget {
  final String categoryId;
  final String title;
  final num price;
  final String description;
  final List<Rating> rating;
  final List<LessonsModel> lessons;

  CourseDetailsBox({
    super.key,
    required this.title,
    required this.categoryId,
    required this.price,
    required this.description,
    required this.rating,
    required this.lessons,
  });

  double getAverageRating(List<Rating> ratings) {
    if (ratings.isEmpty) return 0.0;
    double total = ratings.fold(0, (sum, r) => sum + r.rate);
    return total / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Category + Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryId,
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    getAverageRating(rating).toStringAsFixed(1),
                    style: TextStyle(                        color:Theme.of(context).primaryColor,

                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),

          /// Course Title
          Text(
            title,
            style: TextStyle(                        color:Theme.of(context).primaryColor,

              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          /// Class Count & Hours
          Row(
            children: [
              Icon(Icons.people, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                '${lessons.length} Class',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                '42 Hours',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          /// Price
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$$price',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff0961F5),
              ),
            ),
          ),
          // SizedBox(height: 4.h),

          /// About Section only
          Align(alignment: AlignmentGeometry.topLeft,
            child: Container(
              width: 80.w,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.shade100,
                    Colors.blueAccent.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'About',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          )
,

          SizedBox(height: 10.h),

          /// Description
          Text(
            description,
            style: TextStyle(
              color:Theme.of(context).disabledColor,

              fontSize: 12.sp,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
