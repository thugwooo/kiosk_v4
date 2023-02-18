import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/filter_controller.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/screens/components/petfood_detail_container.dart';

import '../data/category.dart';
import '../data/screen.dart';

class BasicForm extends StatelessWidget {
  BasicForm({super.key});

  var screen_controller = Get.put(ScreenController());
  var user_controller = Get.put(UserController());
  var filter_controller = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                _header(),
                Obx(
                  () => Expanded(
                    child: screen_list[screen_controller.screen_index.value],
                  ),
                ),
                _custom_bottom_navigation(),
              ],
            ),
            _speech_bubble(),
            _background(),
            _search_container(),
            Obx(
              () => Visibility(
                visible: screen_controller.petfood_detail_container.value,
                child: PetfoodDetailContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _search_container() {
    return Obx(
      () => Visibility(
        visible: screen_controller.search_container.value,
        child: Positioned(
          left: 50.w,
          top: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500.w,
                height: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.w,
                          height: 30.h,
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10.w)),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '검색어를 입력해주세요.',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Icon(
                                  Icons.search,
                                  size: 20.w,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              screen_controller.set_search_text(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Visibility(
                      visible: screen_controller.search_text_bool(),
                      child: Container(
                        width: 400.w,
                        height: 200.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: screen_controller.search_petfood_length.value,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 5.w),
                              child: InkWell(
                                child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3, // soften the shadow
                                        spreadRadius: 3, //extend the shadow
                                        offset: Offset(2.w, 2.h),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      // Image.asset('assets/images/A000001.png'),
                                      Image.asset('assets/images/' + screen_controller.search_petfood[index]['eng_name'] + '.png'),
                                      SizedBox(height: 5.h),
                                      Text(screen_controller.search_petfood[index]['brand'], style: TextStyle(fontSize: 9.sp)),

                                      Text(screen_controller.search_petfood[index]['short_name'], style: TextStyle(fontSize: 9.sp)),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  screen_controller.set_petfood_detail_container(petfood_data: screen_controller.search_petfood[index]);
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 3.w),
              InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 30.w,
                ),
                onTap: () {
                  screen_controller.set_search_container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx _background() {
    return Obx(
      () => Visibility(
        visible: screen_controller.grey_background.value,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Obx _speech_bubble() {
    return Obx(
      () => Visibility(
        visible: screen_controller.show_speech_bubble(),
        child: Stack(
          children: [
            Positioned(
              left: 330.w,
              bottom: 55.h,
              child: Container(
                width: 165.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: mint_color,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(
                    child: Text(
                  '우리 아이에게 딱 맞는 사료를 찾으려면',
                  style: TextStyle(fontSize: 9.sp),
                )),
              ),
            ),
            Positioned(
              left: 348.w,
              bottom: 47.h,
              child: Image.asset(
                'assets/icons/triangle.png',
                width: 13.w,
                color: mint_color,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _custom_bottom_navigation() {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: background_color))),
      child: Row(
        children: [
          _navi_button(index: 0),
          _navi_button(index: 1),
          _navi_button(index: 2),
          _navi_button(index: 3),
          Expanded(
            child: InkWell(
              child: Container(
                height: 63.h,
                decoration: BoxDecoration(color: grey_2),
                child: Stack(
                  children: [
                    Positioned(
                      right: 20.w,
                      top: 17.h,
                      child: Container(
                        width: 135.w,
                        height: 26.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.w),
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30.w,
                      top: 20.h,
                      child: Image.asset(
                        'assets/icons/magnifying-glass.png',
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                screen_controller.set_search_container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _navi_button({index}) {
    return Obx(
      () => InkWell(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: screen_controller.is_selected_bottom_navi_index(index) ? main_color : grey_2,
              ),
              width: 96.w,
              height: 63.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    navi_icons[index],
                    width: 18.w,
                    color: screen_controller.is_selected_bottom_navi_index(index) ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    navi_Text[index],
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: screen_controller.is_selected_bottom_navi_index(index) ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: [0, 1].contains(index),
              child: Positioned(
                left: 30.w,
                child: Visibility(
                  visible: screen_controller.is_selected_bottom_navi_index(index),
                  child: Image.asset(
                    'assets/icons/triangle.png',
                    width: 13.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          if (index == 0) {
            sort_location();
          }
          screen_controller.set_navi_index(index);
        },
      ),
    );
  }

  Widget _header() {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Column(
            children: [
              Image.asset(
                'assets/icons/vertical_logo.png',
                width: 126.w,
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  _pet_button(index: 0),
                  _pet_button(index: 1),
                ],
              ),
            ],
          ),
          SizedBox(width: 15.w),
          // TODO: 광고
          Container(
            width: 420.w,
            height: 83.h,
            child: Image.asset('assets/images/banner_1.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _pet_button({index}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: 62.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: user_controller.is_selected_user_info(text: 'pet', index: index) ? main_color : grey_2,
            borderRadius:
                index == 0 ? BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)) : BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              '${pet_text[index]}',
              style: TextStyle(fontSize: 11.sp, color: user_controller.is_selected_user_info(text: 'pet', index: index) ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: () {
          user_controller.set_user_info(text: 'pet', value: index);
          user_controller.set_petfood_list_length();
          filter_controller.change_pet();
        },
      ),
    );
  }
}
