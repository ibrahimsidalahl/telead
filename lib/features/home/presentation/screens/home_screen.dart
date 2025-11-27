import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telead/features/home/presentation/screens/course_details_screen.dart';

import '../../../../core/styles/app_style.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../bookmark/presentation/manger/book_mark_cubit.dart';
import '../manger/category_cubit/category_cubit.dart';
import '../manger/category_cubit/category_states.dart';
import '../manger/course_cubit/course_cubit.dart';
import '../manger/course_cubit/course_state.dart';
import '../manger/toggle_cubit/toggle_category_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final categoryCubit = context.read<CategoryCubit>();
      categoryCubit.fetchCategories().then((_) {
        if (!mounted) return;
        final categoryState = categoryCubit.state;
        if (categoryState is CategoryLoaded &&
            categoryState.categories.isNotEmpty) {
          final firstCategoryId = categoryState.categories.first.id;
          context.read<ToggleCategoryCubit>().selectCategory(0);
          context.read<CourseCubit>().fetchCategories(firstCategoryId);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthCubit cubit) => cubit.currentUser);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: const Color(0xff0961F5),
        onRefresh: () async {
          final categoryCubit = context.read<CategoryCubit>();
          await categoryCubit.fetchCategories();
          final categoryState = categoryCubit.state;
          if (categoryState is CategoryLoaded &&
              categoryState.categories.isNotEmpty) {
            final selectedIndex =
                context.read<ToggleCategoryCubit>().selectedCategoryId;
            final selectedCategoryId =
                categoryState.categories[selectedIndex].id;
            await context
                .read<CourseCubit>()
                .fetchCategories(selectedCategoryId);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              /// Greeting
              SliverToBoxAdapter(
                  child: GreetingSection(
                      userName: '${user!.firstName} ${user.secondName}')),

              SliverToBoxAdapter(child: SizedBox(height: 10.h)),

              /// Offer Banner
              const SliverToBoxAdapter(child: OfferBanner()),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              /// Categories
               SliverToBoxAdapter(
                child: Text('Categories',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
              ),
              const CategoryList(),

              SliverToBoxAdapter(child: SizedBox(height: 10.h)),

              /// Courses
              const CourseList(),

              // SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            ],
          ),
        ),
      ),
    );
  }
}

////// Greeting Section
class GreetingSection extends StatelessWidget {
  final String userName;

  const GreetingSection({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 230.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, $userName', style: AppStyles.style24(context)),
                SizedBox(height: 10.h),
                Text('What would you like to learn today?',
                    style: AppStyles.styleGray14(context)),
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
            icon: Icon(Icons.notifications, size: 24.sp),
          ),
        ),
      ],
    );
  }
}

////// Offer Banner

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> offers = [
      {
        "title": "25% OFF",
        "subtitle": "Today’s Special",
        "desc":
        "Get 25% discount on all Flutter & Dart courses. Only valid today!",
        "image": "assets/offer.png",
      },
      {
        "title": "Free Certificate",
        "subtitle": "On Completion",
        "desc":
        "Earn a free certificate when you complete selected courses this month.",
        "image": "assets/offer.png",
      },
      {
        "title": "Scholarship",
        "subtitle": "Top Learners",
        "desc":
        "Win a 100% scholarship by being among the top learners this month.",
        "image": "assets/offer.png",
      },
    ];

    return CarouselSlider(

      options: CarouselOptions(
        height: 160.h,
        autoPlay: true,
        animateToClosest: true,


        autoPlayAnimationDuration: Duration( milliseconds: 500),
        enlargeCenterPage: true,
        viewportFraction: 1,
      ),
      items: offers.map((offer) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(offer["image"]!),
                  fit: BoxFit.fill,
                ),
                color: const Color(0xff0961F5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer["title"]!,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),

                    ),
                    SizedBox(height: 6.h),
                    Text(
                      offer["subtitle"]!,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6.h),
                    Flexible(
                      child: Text(
                        offer["desc"]!,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18.sp,

                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,

                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}


////// Categories List
class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedId =
        context.select((ToggleCategoryCubit cubit) => cubit.selectedCategoryId);

    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is CategoryLoaded) {
          final categories = state.categories;
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedId == index;
                  return InkWell(
                    onTap: () {
                      context.read<ToggleCategoryCubit>().selectCategory(index);
                      context.read<CourseCubit>().fetchCategories(category.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xff0961F5)
                              : const Color(0xffE8F1FF),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category.title,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
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
            ),
          );
        } else if (state is CategoryError) {
          return SliverToBoxAdapter(
              child: Center(child: Text('Error: ${state.message}')));
        }
        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

////// Courses List
class CourseList extends StatelessWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        if (state is CourseLoading) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is CourseLoaded) {
          final courses = state.course;
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 240.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailsScreen(
                                  category_Id: course.id,
                                  title: course.title,
                                  price: course.price,
                                  instructor_Id: course.instructorId,
                                  image_Url: course.imageUrl,
                                  description: course.description,
                                  lessons: course.lessons,
                                  rating: course.rating,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 260.w,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: course.imageUrl,
                                  height: 120.h,
                                  width: 260.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    height: 120.h,
                                    color: Colors.grey[200],
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) {
                                    print(
                                        "Image load error: $error | url: $url");
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(course.categoryId,
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(course.title,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text('\$${course.price}',
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                          '${course.studentEnrolled.length} Std',style: TextStyle(color: Theme.of(context).primaryColor),),
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
                          child: IconButton(
                            onPressed: () => context
                                .read<BookmarkCubit>()
                                .toggleBookmark(
                                    'categories/${course.categoryId}/courses/course1'),
                            icon: Icon(Icons.bookmark_border,
                                size: 24.sp, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is CourseError) {
          return SliverToBoxAdapter(
              child: Center(child: Text('Error: ${state.message}')));
        }
        return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
