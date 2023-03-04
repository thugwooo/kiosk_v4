import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../components/style.dart';
import '../../data/screen.dart';

class CurationPetScreen extends StatelessWidget {
  CurationPetScreen({super.key});
  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    user_controller.set_pet_list();
    return Column(
      children: [
        SizedBox(height: 45.h),
        Expanded(
          child: Obx(
            () => Container(
              width: 600.w,
              decoration: BoxDecoration(color: grey_1),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (var pet_index = 0; pet_index < user_controller.pet_length.value; pet_index++) _pet_container_form(pet_index),
                    _add_new_pet_button(),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 45.h),
      ],
    );
  }

  InkWell _add_new_pet_button() {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Container(
          width: 100.w,
          height: 130.h,
          decoration: pet_container_style,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.control_point_duplicate,
                color: main_color,
                size: 30.w,
              ),
              SizedBox(height: 10.h),
              Text('추가 등록하기', style: TextStyle(fontSize: 13.sp)),
            ],
          ),
        ),
      ),
      onTap: () {
        user_controller.add_new_pet_button(user_controller.user_info['member_id'].value);
        screen_controller.set_screen_index(ScreenState.curation_input_screen.index);
      },
    );
  }

  Stack _pet_container_form(int pet_index) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Container(
            width: 100.w,
            height: 130.h,
            decoration: pet_container_style,
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Container(
                  width: 90.w,
                  child: Center(
                    child: Text(
                      user_controller.pet_list[pet_index]['name'],
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: main_color),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user_controller.pet_age_sex_data(index: pet_index),
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    user_controller.pet_list[pet_index]['sex'] == '0' ? Icon(Icons.male, color: main_color, size: 15.w) : Icon(Icons.female, color: Colors.red, size: 15.w),
                  ],
                ),
                SizedBox(height: 4.h),
                InkWell(
                  child: Container(
                    width: 40.w,
                    height: 15.h,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Center(
                      child: Text('정보 수정'),
                    ),
                  ),
                  onTap: () {
                    user_controller.set_user_info_button(pet_index);
                    screen_controller.set_screen_index(ScreenState.curation_input_screen.index);
                  },
                ),
                SizedBox(height: 10.h),
                InkWell(
                  child: Container(
                    width: 75.w,
                    height: 22.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w), color: main_color),
                    child: Center(
                      child: Text('추천받기', style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  onTap: () {
                    user_controller.recommend_button(pet_index);
                    screen_controller.set_screen_index(ScreenState.curation_recommend_petfood_screen.index);
                  },
                ),
                SizedBox(height: 5.h),
                InkWell(
                  child: Container(
                    width: 75.w,
                    height: 22.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w), color: Color.fromRGBO(239, 245, 255, 1)),
                    child: Center(
                      child: Text('사료기록', style: TextStyle(fontSize: 10.sp, color: main_color)),
                    ),
                  ),
                  onTap: () {
                    user_controller.set_selected_pet_index(pet_index);
                    screen_controller.set_screen_index(ScreenState.curation_record_petfood_screen.index);
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: InkWell(
            child: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.w), color: main_color),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 15.w,
              ),
            ),
            onTap: () {
              user_controller.delete_button(pet_index);
            },
          ),
        ),
      ],
    );
  }
}
