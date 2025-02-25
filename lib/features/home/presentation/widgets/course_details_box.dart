import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telead/features/home/presentation/manger/toggle.dart';

class CourseDetailsBox extends StatelessWidget {
  String category_id;
  String title;
  num price;
  String description;
   CourseDetailsBox({super.key,
     required this.title,
     required this.category_id,
     required this.price,
     required this.description,

   });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w, // Adjust the width to fit the content
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
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
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category_id,
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '4.2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Course title
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          // Class and hours info
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14.sp,
                color: Colors.grey,
              ),
              SizedBox(width: 4.w),
              Text(
                '21 Class',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.access_time,
                size: 14.sp,
                color: Colors.grey,
              ),
              SizedBox(width: 4.w),
              Text(
                '42 Hours',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Price tag
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$$price',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: (){

                    Provider.of<ToggleProvider>(context, listen: false).toggleColors();
                  },
                  child: Container(
                    width: 140.w,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color:       Provider.of<ToggleProvider>(context, listen: false).activeColor1
                      ,
                    ),
                    child: Center(
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){

                    Provider.of<ToggleProvider>(context, listen: false).toggleColors();
                  },
                  child: Container(
                    width: 128.w,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Provider.of<ToggleProvider>(context, listen: false).activeColor2,
                    ),
                    child: Center(
                      child: Text(
                        'Curriculum',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Description with Read More
          Text(
            description,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
