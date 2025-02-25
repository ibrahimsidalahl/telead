import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_style.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search,size: 20.sp,),
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        hintText: 'Search for..',
        hintStyle: AppStyles.styleGray18(context),
        suffixIcon: Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: (){
              print('filter button');
            },
            child: Container(
              height: 15.h,
              width: 10.w,
              decoration: BoxDecoration(
                color: Color(0xff0961F5),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              child: Image.asset('assets/filter_icon.png',),
            ),
          ),
        ),
      ),
    );
  }
}
