import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../data/category.dart';

class PopularCategoryScreen extends StatelessWidget {
  PopularCategoryScreen({super.key});
  var screen_controller = Get.put(ScreenController());
  var user_controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 30.w),
      child: Obx(
        () => Wrap(
          children: [
            for (var index = 0; index < popular_category_text[user_controller.user_info['pet'].value].length; index++)
              Padding(
                padding: EdgeInsets.only(right: 30.w, bottom: 20.h),
                child: _category_container_form(index),
              )
          ],
        ),
      ),
    );
  }

  InkWell _category_container_form(index) {
    return InkWell(
      child: Obx(
        () => Container(
          width: 92.w,
          height: 115.h,
          decoration: BoxDecoration(
            color: grey_0,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 1.0.w,
                spreadRadius: 1.0.w,
                offset: Offset(1.w, 1.h),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${popular_category_text[user_controller.user_info["pet"].value][index]}',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      onTap: () {
        screen_controller.set_screen_index(4);
        screen_controller.set_pop_category_index(index);
      },
    );
  }
}
