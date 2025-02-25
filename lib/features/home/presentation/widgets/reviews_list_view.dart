import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../auth/data/user_model.dart';
import '../../../profile/presentation/manger/user_provider.dart';
import '../../data/models/rating_model.dart';

class ReviewsListView extends StatefulWidget {
  final List<Rating> rating;

  const ReviewsListView({
    super.key,
    required this.rating,
  });

  @override
  State<ReviewsListView> createState() => _ReviewsListViewState();
}

class _ReviewsListViewState extends State<ReviewsListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 * widget.rating.length.toDouble(),
      child: ListView.builder(
        itemCount: widget.rating.length,
        itemBuilder: (BuildContext context, int index) {
          final currentRating = widget.rating[index];

          return  Column(
                children: [
                  Container(
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
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 28.r,
                        backgroundColor: Colors.white,
                        backgroundImage: widget.rating[index].userImage!= null
                            ? NetworkImage(widget.rating[index].userImage!)
                            : const AssetImage(
                            'assets/images/default_avatar.png')
                        as ImageProvider, // Default image if no user image
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 196.w,
                            child: Text(
                               '${widget.rating[index].userName!}' // User's name
                                  , // Fallback name
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${currentRating.rate}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          Text(
                            currentRating.comment,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.all(12.w),
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  )
                ],
              );

        },
      ),
    );
  }
}