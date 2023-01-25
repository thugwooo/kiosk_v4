import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';

import '../../components/style.dart';
import '../../data/curation.dart';

class CurationMainScreen extends StatelessWidget {
  CurationMainScreen({super.key});
  var screen_controller = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 60.h),
        Text(
          '반려동물 정보만 입력하면 연령과 건강 사항 등을 고려하여\n가장 적합한 제품들을 추천받을 수 있어요.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _select_user_type(0),
            SizedBox(width: 30),
            _select_user_type(1),
          ],
        ),
      ],
    );
  }

  Widget _select_user_type(int index) {
    return InkWell(
      child: Container(
        width: 130.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: grey_color,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Center(
          child: Text(
            user_type[index],
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ),
      onTap: () {
        screen_controller.set_screen_index(index + 5);
      },
    );
  }
}
