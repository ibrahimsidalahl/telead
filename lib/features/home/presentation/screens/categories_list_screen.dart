// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// import '../../../../core/styles/app_style.dart';
// import '../../../../core/widgets/custom_search_bar.dart';
// import '../manger/category_cubit/category_cubit.dart';
// import '../manger/category_cubit/category_states.dart';
// import 'category_details_screen.dart';
//
// class CategoriesListScreen extends StatelessWidget {
//   const CategoriesListScreen({super.key});
//
//   static const routeName = 'categoriesList';
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CategoryCubit()..fetchCategories(),
//       child: Scaffold(
//         backgroundColor: const Color(0xffF5F9FF),
//         appBar: AppBar(
//           backgroundColor: const Color(0xffF5F9FF),
//           title: Text(
//             'All Category',
//             style: AppStyles.style24(context),
//           ),
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(
//               Icons.arrow_back,
//               size: 24.sp,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               SizedBox(height: 20.h),
//               const CustomSearchBar(),
//               SizedBox(height: 20.h),
//               Expanded(
//                 child: BlocBuilder<CategoryCubit, CategoryState>(
//                   builder: (context, state) {
//                     if (state is CategoryLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is CategoryLoaded) {
//                       final categories = state.categories;
//                       return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio: 0.9,
//                           crossAxisSpacing: 4.h,
//                           mainAxisSpacing: 2.w,
//                         ),
//                         itemCount: categories.length,
//                         itemBuilder: (context, index) {
//                           final category = categories[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CategoryDetailsScreen(id: category.id),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   width: 50,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(category.image_url),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10.h),
//                                 Text(category.title),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else if (state is CategoryError) {
//                       return Center(child: Text('Error: ${state.message}'));
//                     }
//                     return const SizedBox();
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
