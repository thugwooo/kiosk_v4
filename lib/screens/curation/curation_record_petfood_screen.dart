import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../components/style.dart';
import '../../data/petfood.dart';

class CurationRecordPetfoodScreen extends StatelessWidget {
  CurationRecordPetfoodScreen({super.key});
  var user_controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    user_controller.get_selected_petfood();
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            SizedBox(height: 15.h),
            Text(
              user_controller.pet_list[user_controller.selected_pet_index.value]['name'] + '(이)가 먹을 수 있는 사료 리스트',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: main_color),
            ),
            SizedBox(height: 15.h),
            Container(
              width: 600.h,
              height: 150.h,
              decoration: BoxDecoration(color: grey_color),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var selected_petfood_index = 0; selected_petfood_index < user_controller.selected_petfood_list_length.value; selected_petfood_index++)
                      _selected_petfood_form(index: selected_petfood_index),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            InkWell(
              child: Container(
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: main_color,
                ),
                child: Center(child: Text('저장하기', style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold))),
              ),
              onTap: () {
                user_controller.post_selected_petfood();
              },
            ),
            SizedBox(height: 15.h),
            Wrap(
              spacing: 15.w,
              runSpacing: 15.h,
              children: [
                // TODO : petfood_list 에 있으면 출력하지 않기
                for (var petfood_index = 0; petfood_index < petfood_list[user_controller.user_info['pet'].value].length; petfood_index++)
                  if (user_controller.selected_petfood_list.indexOf(petfood_list[user_controller.user_info['pet'].value][petfood_index]['short_name']) == -1) _petfood_form(petfood_index),
              ],
            )
          ],
        ),
      ),
    );
  }

  InkWell _petfood_form(int petfood_index) {
    return InkWell(
      child: Column(
        children: [
          Container(
            width: 130.w,
            height: 130.h,
            color: grey_color,
            // TODO: 사진
            child: Image.asset('assets/images/A000001.png'),
          ),
          Container(
            width: 130.w,
            child: Text(
              petfood_list[user_controller.user_info['pet'].value][petfood_index]['short_name'].toString(),
            ),
          ),
        ],
      ),
      onTap: () {
        user_controller.set_selected_petfood_list(petfood_list[user_controller.user_info['pet'].value][petfood_index]['short_name']);
      },
    );
  }

  Stack _selected_petfood_form({index}) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Container(
            width: 80.w,
            height: 100.h,
            decoration: pet_container_style,
            child: Column(
              children: [
                Image.asset('assets/images/A000001.png'),
                Text(user_controller.selected_petfood_list[index]),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5.w,
          top: 5.h,
          child: InkWell(
            child: Icon(
              Icons.do_not_disturb_on,
              size: 20.w,
              color: main_color,
            ),
            onTap: () {
              user_controller.set_selected_petfood_list(user_controller.selected_petfood_list[index]);
            },
          ),
        ),
      ],
    );
  }
}
