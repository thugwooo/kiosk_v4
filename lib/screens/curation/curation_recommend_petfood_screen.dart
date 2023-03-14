import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/slider_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/screens/components/petfood_form.dart';

import '../../components/basic_function.dart';
import '../../components/style.dart';
import '../../data/category.dart';
import '../../data/screen.dart';

class CurationRecommendPetfoodScreen extends StatelessWidget {
  CurationRecommendPetfoodScreen({super.key});
  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());
  var slider_controller = Get.put(SliderController());
  @override
  Widget build(BuildContext context) {
    user_controller.get_curation_petfood();
    return Stack(
      children: [
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '[${user_controller.curation_data['name']}를 위한 맞춤형 사료]',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 65.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.7), blurRadius: 1.0.w, spreadRadius: 1.0.w, offset: Offset(1.w, 1.h)),
                        ],
                      ),
                      child: Center(child: Text('저장하기', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500))),
                    ),
                  ],
                ),
              ),
              Container(width: 600.w, height: 1.h, color: main_color),
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                height: slider_controller.show_pet_info.value ? 48.h : 0.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 5.h),
                  child: Row(
                    children: [
                      _pet_header_info_container(width: 80.w, title: '연령', contents: '${user_controller.curation_data['life_stage']} (${user_controller.curation_data['age']}세)'),
                      Container(width: 1.w, height: 35.h, color: Colors.black),
                      SizedBox(width: 15.w),
                      _pet_header_info_container(width: 80.w, title: '몸무게', contents: '${user_controller.curation_data['weight']}kg'),
                      Container(width: 1.w, height: 35.h, color: Colors.black),
                      SizedBox(width: 15.w),
                      _pet_header_info_container(width: 115.w, title: '견종', contents: '${user_controller.curation_data['size']}견 (${user_controller.curation_data['breed']})'),
                      Container(width: 1.w, height: 35.h, color: Colors.black),
                      SizedBox(width: 15.w),
                      _pet_header_info_container(width: 115.w, title: '알러지', contents: '${list_to_str(user_controller.curation_data['algs'])}'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 600.w,
                height: 42.h,
                decoration: BoxDecoration(color: Color.fromRGBO(228, 228, 228, 1)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [for (var h_index = 0; h_index < user_controller.curation_data['health'].length; h_index++) _healthcare_container(h_index)],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  controller: slider_controller.scroll.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sort_container(),
                      SizedBox(height: 15.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        child: Wrap(
                          spacing: 20.w,
                          runSpacing: 10.h,
                          children: [
                            for (var index = 0; index < user_controller.curation_petfood_length.value; index++)
                              PetfoodForm(
                                petfood_data: user_controller.curation_petfood[index],
                                width: 95.w,
                                height: 128.h,
                                img_size: 65.w,
                                top_space: 10.h,
                                bottom_space: 5.h,
                                curation: true,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 5.w,
          bottom: 5.h,
          child: InkWell(
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(color: main_color, borderRadius: BorderRadius.circular(30.w)),
                child: Icon(
                  Icons.arrow_back,
                  size: 20.w,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                screen_controller.set_screen_index(ScreenState.curation_pet_screen.index);
              }),
        ),
      ],
    );
  }

  Container _healthcare_container(int h_index) {
    return Container(
      width: 88.w,
      height: 22.h,
      decoration: BoxDecoration(color: health_background_color[h_index], border: Border.all(width: 1.w, color: health_border_color[h_index]), borderRadius: BorderRadius.circular(5.w)),
      child: Center(
        child: Text('${user_controller.curation_data['health'][h_index]}', style: TextStyle(fontSize: 12.sp)),
      ),
    );
  }

  Container _pet_header_info_container({width, title, contents}) {
    return Container(
      width: width,
      height: 35.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${title}',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            '${contents}',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Row _sort_container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _sort_button(index: 0),
        SizedBox(width: 10.w),
        Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        SizedBox(width: 10.w),
        _sort_button(index: 1),
        SizedBox(width: 10.w),
        Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        SizedBox(width: 10.w),
        _sort_button(index: 2),
        SizedBox(width: 10.w),
        // Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        // SizedBox(width: 4.w),
        // _sort_button(index: 3),
        // SizedBox(width: 4.w),
        // Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        // SizedBox(width: 4.w),
        // _sort_button(index: 4),
      ],
    );
  }

  _sort_button({index}) {
    return Obx(
      () => InkWell(
        child: Text(
          index != 0 ? '${sort_text[index]}' : '루이스홈 추천',
          style: TextStyle(
            fontSize: 8.sp,
            color: screen_controller.is_selected_sort_index(index) ? Colors.black : Color.fromRGBO(152, 152, 152, 1),
            fontWeight: screen_controller.is_selected_sort_index(index) ? FontWeight.bold : FontWeight.w400,
          ),
        ),
        onTap: () {
          screen_controller.set_sort_index(index);
          user_controller.set_curation_petfood_length();
          sort_curation_petfood(sort_index: index, petfood_list: user_controller.curation_petfood);
        },
      ),
    );
  }

  Widget _pet_info_row({title, curation_info}) {
    return Row(
      children: [
        Container(
          width: 100.w,
          child: Text('${title}', style: TextStyle(fontSize: 11.sp)),
        ),
        Text(
          '${curation_info}',
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
