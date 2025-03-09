
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/styles/app_style.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../../profile/presentation/manger/user_provider.dart';
import '../manger/category_provider.dart';
import '../manger/courses_provider.dart';
import '../manger/toggle_category.dart';
import 'categories_list_screen.dart';
import 'course_details_screen.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key,required this.user_id});

  static const routeName = 'home';
  String user_id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<CategoryProvider>(context, listen: false).fetchData().then((_) {
          final categoriesProvider = Provider.of<CategoryProvider>(context, listen: false);
          // Check if categories exist and fetch the first category's courses
          if (categoriesProvider.categories != null && categoriesProvider.categories!.isNotEmpty) {
            final firstCategoryId = categoriesProvider.categories!.first.id;

            // Set the first category as selected by default
            Provider.of<ToggleCategoryProvider>(context, listen: false).selectedCategoryId = 0;

            // Fetch courses for the first category
            Provider.of<CoursesProvider>(context, listen: false).fetchData(firstCategoryId);
          }
        });

        // Fetch the user data
        Provider.of<UsersProvider>(context, listen: false).fetchUserData(widget.user_id);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final categoriesProvider = context.watch<CategoryProvider>();
    final coursesProvider = context.watch<CoursesProvider>();
    final selectedCategoryId = context.watch<ToggleCategoryProvider>();
    final user = context.watch<UsersProvider>();


    return Scaffold(
      backgroundColor: const Color(0xffF5F9FF),
      body:  user.user != null ? Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(
                    width: 230.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${user.user!.first_name} ${user.user!.second_name} ',
                            style: AppStyles.style24(context),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'What would you like to learn today? Search Below.',
                            style: AppStyles.styleGray14(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xff167F71)),
                    ),
                    child: IconButton(
                      color: const Color(0xff167F71),
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              const CustomSearchBar(),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/offer.png'), fit: BoxFit.fill),
                  color: const Color(0xff0961F5),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                height: 160.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '25% OFF*',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Today’s Special',
                        style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Get a Discount for Every Course Order only Valid for Today.!',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ), // Full width
              ),
              SizedBox(height: 16.h),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, CategoriesListScreen.routeName);
                    },
                    child: Text(
                      'SEE ALL',
                      style: TextStyle(
                          fontSize: 12.sp, color: const Color(0xff0961F5)),
                    ),
                  ),
                ],
              ),
              categoriesProvider.categories != null
                  ? SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoriesProvider.categories!.length,
                        itemBuilder: (context, index) {
                          final category = categoriesProvider.categories![index];

                          return InkWell(
                            onTap: () {
                              selectedCategoryId.selectedCategoryId =
                                  categoriesProvider.categories!.indexOf(categoriesProvider.categories![index]);
                              print('2222222222222222222   ${categoriesProvider.categories!.indexOf(categoriesProvider.categories![index])}   ');

                              Provider.of<CoursesProvider>(context,
                                      listen: false)
                                  .fetchData(
                                  categoriesProvider.categories![index].id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        selectedCategoryId.selectedCategoryId ==
                                            categoriesProvider.categories!.indexOf(categoriesProvider.categories![index])
                                            ? const Color(0xff0961F5)
                                            : const Color(0xffE8F1FF),
                                    borderRadius: BorderRadius.circular(24.r)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      category.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                          color: selectedCategoryId.selectedCategoryId ==
                                              categoriesProvider.categories!.indexOf(categoriesProvider.categories![index])
                                              ? Colors.white
                                              : const Color(0xff202244)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),

              SizedBox(height: 10.h),

              // Courses Section
              SizedBox(
                height: 240.h, // Appropriate height for courses list
                child: coursesProvider.courses != null
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coursesProvider.courses!.length,
                        itemBuilder: (context, index) {
                          final course = coursesProvider.courses![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(children: [
                              InkWell(
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
                                        lessons: course.lessons,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 260.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              course.imageUrl,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          course.categoryId,
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 240.w,
                                              child: Text(
                                                course.title,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '\$${course.price}',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                                '${course.studentEnrolled.length} Std'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 120.h,
                                right: 8.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(Icons.bookmark_border,
                                        size: 24.sp, color: Colors.green),
                                  ),
                                ),
                              )
                            ]),
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
      ): const Center(
        child: CircularProgressIndicator(color: Color(0xff0961F5),),
      ),
    );
  }
}
