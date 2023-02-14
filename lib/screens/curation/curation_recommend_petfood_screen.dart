import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    user_controller.get_curation_petfood();
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    '[ ${user_controller.curation_data["name"]}를 위한 맞춤형 사료 ]',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 400.w,
                        child: Text(
                          user_controller.explain_text(),
                          style: TextStyle(fontSize: 10.sp),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: 60.w,
                          height: 20.h,
                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 0.5.w)),
                          child: Center(child: Text('수정하기', style: TextStyle(fontSize: 10.sp))),
                        ),
                        onTap: () {
                          user_controller.modify_button();
                          screen_controller.set_screen_index(ScreenState.curation_input_screen.index);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    width: 600.w,
                    color: grey_color,
                    child: Column(
                      children: [
                        _pet_info_row(title: '연령', curation_info: user_controller.curation_data['life_stage']),
                        SizedBox(height: 5.h),
                        _pet_info_row(title: '제외된 단백질', curation_info: list_to_str([...user_controller.curation_data['algs'], ...user_controller.curation_data['alg_sub']])),
                        SizedBox(height: 5.h),
                        _pet_info_row(title: '건강 고려사항', curation_info: list_to_str(user_controller.curation_data['health'])),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  _sort_container(),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.only(left: 5.w, top: 5.h),
                    child: Wrap(
                      spacing: 20.w,
                      runSpacing: 10.h,
                      children: [
                        for (var index = 0; index < user_controller.curation_petfood_length.value; index++)
                          PetfoodForm(
                            petfood_data: user_controller.curation_petfood[index],
                            width: 112.w,
                            height: 140.h,
                            img_size: 80.w,
                            top_space: 10.h,
                            bottom_space: 5.h,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

  Row _sort_container() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _sort_button(index: 0),
        SizedBox(width: 4.w),
        Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        SizedBox(width: 4.w),
        _sort_button(index: 1),
        SizedBox(width: 4.w),
        Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        SizedBox(width: 4.w),
        _sort_button(index: 2),
        SizedBox(width: 4.w),
        Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        SizedBox(width: 4.w),
        _sort_button(index: 3),
        SizedBox(width: 4.w),
        Container(width: 1.w, height: 8.h, color: Color.fromRGBO(152, 152, 152, 1)),
        SizedBox(width: 4.w),
        _sort_button(index: 4),
      ],
    );
  }

  _sort_button({index}) {
    return Obx(
      () => InkWell(
        child: Text(
          '${sort_text[index]}',
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
