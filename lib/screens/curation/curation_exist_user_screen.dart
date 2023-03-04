import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../components/style.dart';
import '../../data/screen.dart';

class CurationExistUserScreen extends StatelessWidget {
  CurationExistUserScreen({super.key});
  var screen_controller = Get.put(ScreenController());
  var user_controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    user_controller.phone_number.value = '';
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 50.w),
      color: background_blue_color_2,
      child: Row(
        children: [_left_form(), SizedBox(width: 15.w), _right_form()],
      ),
    );
  }

  Container _right_form() {
    return Container(
      width: 240.w,
      child: Column(
        children: [
          Container(
            width: 240.w,
            height: 85.h,
            decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3.w))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h),
                  child: Text(
                    '휴대폰 번호 입력',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('010 - ', style: TextStyle(fontSize: 22.sp)),
                        Text(
                          user_controller.user_info['member_id'].value == '' ? '1234 - 5678' : user_controller.get_phone_number(),
                          style: TextStyle(fontSize: 22.sp, color: user_controller.user_info['member_id'].value == '' ? Colors.grey : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Table(
            border: TableBorder.symmetric(
              outside: BorderSide.none,
              inside: BorderSide(width: 0.3.w, color: Colors.grey),
            ),
            children: [
              for (var col_index = 0; col_index < 3; col_index++)
                TableRow(children: [
                  for (var row_index = 1; row_index < 4; row_index++) _single_touchpad(col_index * 3 + row_index),
                ]),
              TableRow(
                children: [
                  InkWell(
                    child: Container(
                      color: Colors.white,
                      height: 50.h,
                      child: Center(
                          child: Icon(
                        Icons.backspace,
                        size: 22.w,
                      )),
                    ),
                    onTap: () {
                      user_controller.back_space_phone_number();
                    },
                  ),
                  _single_touchpad(0),
                  Obx(
                    () => InkWell(
                      child: Container(
                        decoration: BoxDecoration(color: user_controller.phone_number_validator() ? main_color : grey_2),
                        height: 50.h,
                        child: Center(
                          child: Text('확 인', style: TextStyle(fontSize: 17.sp, color: user_controller.phone_number_validator() ? Colors.white : Colors.grey)),
                        ),
                      ),
                      onTap: () {
                        if (user_controller.phone_number.value.length != 8) {
                          return;
                        }
                        user_controller.set_user_info(text: 'member_id', value: '010' + user_controller.phone_number.value);
                        user_controller.user_exist().then((value) {
                          if (value) {
                            screen_controller.set_screen_index(ScreenState.curation_pet_screen.index);
                          } else {
                            Get.dialog(AlertDialog(
                              title: Text('등록되지 않은 정보입니다. \n신규 등록 페이지로 이동하시겠습니까?'),
                              actions: [
                                TextButton(
                                    child: Text('예'),
                                    onPressed: () {
                                      Get.back();
                                      screen_controller.set_screen_index(ScreenState.curation_new_user_screen.index);
                                    }),
                                TextButton(
                                    child: Text('아니오'),
                                    onPressed: () {
                                      Get.back();
                                    }),
                              ],
                            ));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _left_form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text('기존에 등록하신', style: TextStyle(fontSize: 19.sp)),
        Text('휴대폰 번호를 입력해 주세요.', style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500)),
        SizedBox(height: 5.h),
        Text('반려동물 정보를 불러올게요!', style: TextStyle(fontSize: 13.sp)),
        SizedBox(height: 30.h),
        Image.asset(
          'assets/sub/curation_dogs.png',
          width: 250.w,
        ),
      ],
    );
  }

  Widget _single_touchpad(index) {
    return InkWell(
      child: Container(
        color: Colors.white,
        height: 50.h,
        child: Center(
          child: Text('${index}', style: TextStyle(fontSize: 22.sp)),
        ),
      ),
      onTap: () {
        user_controller.add_number_phone_number(index);
        print(index);
      },
    );
  }
}
