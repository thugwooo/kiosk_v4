import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/data/petfood.dart';
import 'package:kiosk_v4/screens/components/petfood_form.dart';
import 'package:kiosk_v4/screens/components/sort_petfood_container.dart';

import '../../components/style.dart';
import '../../data/category.dart';

class PopularCategoryDisplayScreen extends StatelessWidget {
  PopularCategoryDisplayScreen({super.key});
  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120.w,
          child: _category_container(),
        ),
        SizedBox(width: 41.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: 420.w, child: SortPetfoodContainer(petfood_list: petfood_list)),
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.only(left: 5.w, top: 5.h),
                    width: 420.w,
                    child: Wrap(
                      spacing: 21.w,
                      runSpacing: 10.h,
                      children: [
                        for (var petfood_index = 0; petfood_index < user_controller.petfood_list_length.value; petfood_index++)
                          if (pop_cate_filter(
                            petfood_data: petfood_list[user_controller.user_info['pet'].value][petfood_index],
                            sort_text: popular_category_text[user_controller.user_info['pet'].value][screen_controller.pop_category_index.value],
                          ))
                            PetfoodForm(
                              petfood_data: petfood_list[user_controller.user_info['pet'].value][petfood_index],
                              width: 123.w,
                              height: 160.h,
                              img_size: 85.w,
                              top_space: 10.h,
                              bottom_space: 5.h,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _category_container() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 45.h),
        for (var index = 0; index < popular_category_text[user_controller.user_info['pet'].value].length; index++) _popular_category_button(index),
      ],
    );
  }

  Widget _popular_category_button(int index) {
    return Obx(
      () => InkWell(
        child: Container(
          // padding: EdgeInsets.only(
          //   left: screen_controller.is_selected_pop_category_index(index) ? 30.w : 20.w,
          //   top: 5.h,
          // ),
          width: 100.w,
          height: 26.h,
          decoration: BoxDecoration(
            color: screen_controller.is_selected_pop_category_index(index) ? main_color : Colors.white,
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Center(
            child: Text(
              '${popular_category_text[user_controller.user_info['pet'].value][index]}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: screen_controller.is_selected_pop_category_index(index) ? FontWeight.bold : FontWeight.w400,
                color: screen_controller.is_selected_pop_category_index(index) ? Colors.white : Color.fromRGBO(128, 128, 128, 1),
              ),
            ),
          ),
        ),
        onTap: () {
          screen_controller.set_pop_category_index(index);
        },
      ),
    );
  }
}
