import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/app_style.dart';
import '../../../../core/widgets/custom_search_bar.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF5F9FF),
      appBar: AppBar(
        backgroundColor:Color(0xffF5F9FF),
        title: Text(
          'Bookmark',
          style: AppStyles.style24(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomSearchBar(),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3,
                ),
                children: [
                  Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(children: [
                            Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/img_1.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      'Graphic Design',
                                      style: TextStyle(
                                          color: Color(0xffFF6B00),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      'Advance Diploma in Graphic Design',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffFAC025),
                                        ),
                                        Text('4.2   | '),
                                        Text('2 Hrs 36 Mins'),
                                      ],
                                    ),
                                  ]),
                            )
                          ])),
                      Positioned(
                          left: 260,
                          bottom: 72,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_border_outlined,
                                size: 22.sp,
                                color: Color(0xff0961F5),
                              )))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
