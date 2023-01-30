import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/controllers/filter_controller.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';

import '../../data/category.dart';

class SortPetfoodContainer extends StatelessWidget {
  SortPetfoodContainer({super.key, required this.petfood_list});
  var screen_controller = Get.put(ScreenController());
  var filter_controller = Get.put(FilterController());
  var petfood_list;
  @override
  Widget build(BuildContext context) {
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

  Widget _sort_button({index}) {
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
          sort_petfood(sort_index: index, petfood_list: petfood_list);
          screen_controller.set_sort_index(index);
          filter_controller.set_filtered_petfood_length();
          filter_controller.filtering_petfood(petfood_list);
        },
      ),
    );
  }
}
