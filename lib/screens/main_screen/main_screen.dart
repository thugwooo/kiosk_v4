import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/screens/components/petfood_form.dart';

import '../../data/petfood.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  var user_controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 20.w, bottom: 10.h),
      child: Container(
        width: 560.w,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (var petfood_index = 0; petfood_index < petfood_list[user_controller.user_info['pet'].value].length; petfood_index++)
                      if (petfood_list[user_controller.user_info['pet'].value][petfood_index]['location'].toString().contains('A'))
                        Padding(
                          padding: EdgeInsets.only(right: 20.0.w),
                          child: PetfoodForm(
                            petfood_data: petfood_list[user_controller.user_info['pet'].value][petfood_index],
                            width: 93.w,
                            height: 128.h,
                          ),
                        ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    for (var petfood_index = 0; petfood_index < petfood_list[user_controller.user_info['pet'].value].length; petfood_index++)
                      if (petfood_list[user_controller.user_info['pet'].value][petfood_index]['location'].toString().contains('B'))
                        Padding(
                          padding: EdgeInsets.only(right: 20.0.w),
                          child: PetfoodForm(
                            petfood_data: petfood_list[user_controller.user_info['pet'].value][petfood_index],
                            width: 93.w,
                            height: 128.h,
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
