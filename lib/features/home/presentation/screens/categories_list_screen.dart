
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telead/features/home/presentation/manger/category_provider.dart';

import '../../../../core/firebase_services/firebase_services.dart';
import '../../../../core/styles/app_style.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import 'category_details_screen.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  static const routeName = 'categoriesList';

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  void initState() {
    super.initState();
    if (mounted) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<CategoryProvider>(context, listen: false).fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = context.watch<CategoryProvider>();
    return Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F9FF),
        title: Text(
          'All Category',
          style: AppStyles.style24(context),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            CustomSearchBar(),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: categoriesProvider.categories != null
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 4.h,
                        mainAxisSpacing: 2.w,
                      ),
                      itemCount: categoriesProvider.categories!.length,
                      itemBuilder: (context, index) {
                        final category = categoriesProvider.categories![index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailsScreen(id: category.id),
                              ),
                            );
                            print(category.id);
                          },
                          child: Container(
                            height: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(category.image_url),
                                      fit: BoxFit
                                          .cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(category.title),
                              ],
                            ),
                          ),
                        );
                      },
                    ): const Center(
                child: CircularProgressIndicator(),
              ),



            ),
          ],
        ),
      ),
    );
  }
}
