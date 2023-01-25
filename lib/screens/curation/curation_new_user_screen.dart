import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../components/style.dart';
import '../../data/screen.dart';

class CurationNewUserScreen extends StatelessWidget {
  CurationNewUserScreen({super.key});

  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 60.h),
          Text(
            '휴대폰 번호 입력을 통해 반려동물 정보를 저장하며\n추후에 재방문 시 기존에 입력한 데이터를 불러오는데 사용됩니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
            () => InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 20.w,
                    color: user_controller.agreement.value ? main_color : Colors.white,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '반려동물 정보 저장 및 데이터 활용에 동의합니다.',
                    style: TextStyle(fontSize: 8.sp, color: Color.fromRGBO(128, 128, 128, 1)),
                  ),
                ],
              ),
              onTap: () {
                user_controller.set_agreement();
              },
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('휴대폰 번호', style: TextStyle(fontSize: 14.sp)),
              SizedBox(width: 10.w),
              Container(
                width: 168.w,
                height: 30.h,
                padding: EdgeInsets.only(left: 10.w),
                decoration: black_border,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: ((value) {
                    user_controller.set_user_info(text: 'member_id', value: value);
                  }),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                child: Container(
                  width: 52.w,
                  height: 30.h,
                  decoration: black_border,
                  child: Center(
                    child: Text('저장', style: TextStyle(fontSize: 15.sp)),
                  ),
                ),
                onTap: () {
                  // TODO : 동의를 안했을때 + 휴대폰번호 길이
                  if (!user_controller.agreement.value) {
                    Get.snackbar('동의 안함', '동의를 해주시오.');
                  } else if (user_controller.user_info['member_id'].value.length != 11) {
                    Get.snackbar('휴대폰 번호!!', '번호를 제대로 입력해주시오');
                  } else {
                    screen_controller.set_screen_index(ScreenState.curation_input_screen.index);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
