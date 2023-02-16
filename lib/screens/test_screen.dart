import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk_v4/data/petfood.dart';

import 'components/petfood_form.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  List<Widget> container_list = [];
  int row_petfood_length = 4;
  @override
  Widget build(BuildContext context) {
    make_list();
    return CarouselSlider(
      options: CarouselOptions(
        height: 270.h,
        scrollDirection: Axis.horizontal,
        // viewportFraction: 0.9,
      ),
      items: container_list,
    );
  }

  dynamic make_list() {
    for (var container_index = 0; container_index < petfood_list[0].length / row_petfood_length * 2 - 1; container_index++) {
      container_list.add(Container(
        // height: 100.h,
        child: Column(
          children: [
            for (var row_index = 0; row_index < 2; row_index++)
              Row(
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
        ),
      ));
    }
  }
}
