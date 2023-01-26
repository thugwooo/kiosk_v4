import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/controllers/filter_controller.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/data/petfood.dart';

import '../../components/style.dart';
import '../../data/category.dart';
import '../components/petfood_form.dart';
import '../components/sort_petfood_container.dart';

class PetfoodFilterScreen extends StatelessWidget {
  PetfoodFilterScreen({super.key});
  var screen_controller = Get.put(ScreenController());
  var filter_controller = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100.w,
          child: _category_container(),
        ),
        SizedBox(width: 61.w),
        Container(
          width: 420.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              _category_button_container(),
              SortPetfoodContainer(petfood_list: petfood_list),
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Container(
                      width: 420.w,
                      child: Wrap(
                        spacing: 21.w,
                        runSpacing: 10.h,
                        children: [
                          for (var petfood_index = 0; petfood_index < filter_controller.filtered_petfood_length[user_controller.user_info['pet'].value].value; petfood_index++)
                            PetfoodForm(
                              petfood_data: filter_controller.filtered_petfood_list[petfood_index],
                              width: 125.w,
                              height: 160.h,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _category_button_container() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          height: 20.h,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var index = 0; index < filter_controller.selected_filter_list_length.value; index++)
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: InkWell(
                      child: Container(
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(196, 221, 255, 1),
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Row(
                            children: [
                              Text(
                                filter_controller.selected_filter_list[user_controller.user_info['pet'].value][index],
                                style: TextStyle(
                                  fontSize: 8.sp,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Icon(Icons.cancel_outlined)
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        filter_controller.remove_selected_filter_list(filter_controller.selected_filter_list[user_controller.user_info['pet'].value][index]);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _category_container() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            '사료 필터',
            style: TextStyle(fontSize: 15.sp),
          ),
        ),
        Divider(
          thickness: 1.h,
          color: Colors.black,
        ),
        // TODO : 카테고리
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                children: [
                  for (var index = 0; index < big_category_list.length; index++) _category_form(category_index: index),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _category_form({category_index}) {
    return Obx(
      () => Column(
        children: [
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  big_category_list[category_index],
                  style: TextStyle(fontSize: 11.sp),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 15.w,
                ),
              ],
            ),
            onTap: () {
              filter_controller.set_unfold_big_category(category_index);
            },
          ),
          Visibility(
            visible: filter_controller.unfold_big_category[category_index].value,
            child: Column(
              children: [
                SizedBox(height: 3.h),
                for (var index = 0; index < filter_controller.category_list_number(category_index); index++)
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, bottom: 3.h),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filter_category_list[user_controller.user_info['pet'].value][category_index][index],
                            style: TextStyle(
                              fontSize: 9.sp,
                            ),
                          ),
                          Icon(
                            filter_controller.selected_filter_category_list[user_controller.user_info['pet'].value][category_index][index].value
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank,
                          ),
                        ],
                      ),
                      onTap: () {
                        filter_controller.set_selected_filter_category_list(category_index, index);
                      },
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h, bottom: 10.h),
                  child: InkWell(
                    child: Container(
                      width: 86.w,
                      height: 18.h,
                      decoration: BoxDecoration(color: grey_color),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            filter_controller.show_all_filter_category[category_index].value ? '접기' : '모두 보기',
                            style: TextStyle(fontSize: 8.sp, color: Color.fromRGBO(102, 102, 102, 1)),
                          ),
                          Icon(
                            filter_controller.show_all_filter_category[category_index].value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            size: 13.w,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      filter_controller.set_show_all_filter_category(category_index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
