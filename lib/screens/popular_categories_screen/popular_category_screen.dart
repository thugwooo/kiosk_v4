import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';

import '../../data/category.dart';

class PopularCategoryScreen extends StatelessWidget {
  PopularCategoryScreen({super.key});
  var screen_controller = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 30.w),
      child: Wrap(
        children: [
          for (var index = 0; index < popular_category_text.length; index++)
            Padding(
              padding: EdgeInsets.only(right: 30.w, bottom: 20.h),
              child: _category_container_form(index),
            )
        ],
      ),
    );
  }

  InkWell _category_container_form(int index) {
    return InkWell(
      child: Container(
        width: 92.w,
        height: 105.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(children: [
          Image.asset(
            'assets/images/A000001.png',
            width: 63.w,
          ),
          Text(
            '${popular_category_text[index]}',
            style: TextStyle(fontSize: 12.sp),
          ),
        ]),
      ),
      onTap: () {
        screen_controller.set_screen_index(4);
      },
    );
  }
}
