import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/data/screen.dart';

import '../../data/curation.dart';

class CurationMainScreen extends StatelessWidget {
  CurationMainScreen({super.key});
  var screen_controller = Get.put(ScreenController());
  var user_controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/sub/curation_main.png', width: 600.w),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _select_user_type(0),
            SizedBox(width: 40),
            _select_user_type(1),
          ],
        ),
      ],
    );
  }

  Widget _select_user_type(int index) {
    return InkWell(
      child: Container(
        width: 160.w,
        height: 60.h,
        decoration: BoxDecoration(color: Color.fromRGBO(248, 249, 250, 1), borderRadius: BorderRadius.circular(10.w), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 1.0.w,
            spreadRadius: 1.0.w,
            offset: Offset(1.w, 1.h),
          ),
        ]),
        child: Center(
          child: Text(
            user_type[index],
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ),
      onTap: () {
        if (index == 0) {
          print('asdf $index ${ScreenState.curation_input_screen.index}');
          screen_controller.is_new_user.value = true;
          user_controller.add_new_pet_button({'member_id': ''});
          screen_controller.set_screen_index(ScreenState.curation_input_screen.index);
        } else {
          screen_controller.is_new_user.value = false;
          screen_controller.set_screen_index(ScreenState.curation_exist_user_screen.index);
        }

        // TODO: 신규회원일때 초기화
      },
    );
  }
}
