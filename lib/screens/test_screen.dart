import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/slider_controller.dart';
import 'package:kiosk_v4/data/petfood.dart';

import 'components/petfood_form.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  int row_petfood_length = 5;
  var slider_controller = Get.put(SliderController());
  var _carousel_controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _custom_carousel(),
        _previous_button(),
        _next_button(),
        Positioned(
          left: 275.w,
          top: 277.h,
          child: Row(
            children: [
              for (var index = 0; index < petfood_list[0].length ~/ row_petfood_length ~/ 2; index++) _page_index_form(index: index),
            ],
          ),
        ),
      ],
    );
  }

  Container _custom_carousel() {
    return Container(
      width: 600.w,
      margin: EdgeInsets.only(top: 14.h),
      child: CarouselSlider.builder(
        carouselController: _carousel_controller,
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          aspectRatio: 2,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            slider_controller.set_current_page_index(index);
          },
        ),
        itemCount: petfood_list[0].length ~/ row_petfood_length ~/ 2,
        itemBuilder: (context, container_index, realIndex) {
          return Column(
            children: [
              for (var row_index = 0; row_index < 2; row_index++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var petfood_index = 0 + row_index * row_petfood_length; petfood_index < row_petfood_length + row_index * row_petfood_length; petfood_index++)
                      if (container_index * row_petfood_length * 2 + container_index < petfood_list[0].length)
                        //
                        Container(
                          margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                          child: PetfoodForm(
                            petfood_data: petfood_list[0][container_index * 8 + petfood_index],
                            width: 93.w,
                            height: 123.h,
                            img_size: 65.w,
                            top_space: 10.h,
                            bottom_space: 5.h,
                          ),
                        ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Positioned _next_button() {
    return Positioned(
      right: 10.w,
      top: 130.h,
      child: InkWell(
        child: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: Colors.grey),
          child: Center(
            child: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 20.w),
          ),
        ),
        onTap: () {
          _carousel_controller.nextPage();
        },
      ),
    );
  }

  Positioned _previous_button() {
    return Positioned(
      left: 10.w,
      top: 130.h,
      child: InkWell(
        child: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: Colors.grey),
          child: Center(
            child: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 20.w),
          ),
        ),
        onTap: () {
          _carousel_controller.previousPage();
        },
      ),
    );
  }

  Widget _page_index_form({index}) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(right: 3.w),
        width: 5.w,
        height: 5.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: slider_controller.is_current_page_index(index) ? Colors.grey : grey_2),
      ),
    );
  }
}
