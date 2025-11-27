import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/features/home/data/models/lessons_model.dart';
import 'package:telead/features/home/presentation/screens/lessons_screen.dart';
import 'package:telead/features/home/presentation/widgets/course_details_box.dart';
import 'package:telead/features/home/presentation/widgets/reviews_list_view.dart';
import '../../data/models/rating_model.dart';

class CourseDetailsScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff0961F5),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonsScreen(lessons: lessons),
            ),
          );
        },
        label: const Text(
          "Start Learning",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.play_circle_outline, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// صورة الكورس مع Gradient و Hero
            Stack(
              children: [
                Hero(
                  tag: image_Url,
                  child: CachedNetworkImage(
                    imageUrl: image_Url,
                    height: 260.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, size: 40, color: Colors.red),
                  ),
                ),
                Container(
                  height: 260.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Center(
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: const Color(0xff0961F5),
                          size: 18.r,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// صندوق تفاصيل الكورس
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: CourseDetailsBox(
                title: title,
                rating: rating,
                // category_id: category_Id,
                categoryId: category_Id,
                price: price,
                description: description,
                lessons: lessons,
              ),
            ),

            /// Reviews
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Reviews",
                      style: TextStyle(
                        color:Theme.of(context).primaryColor,
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  ReviewsListView(rating: rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
