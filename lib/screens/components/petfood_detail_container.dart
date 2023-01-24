import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';

import '../../components/style.dart';

class PetfoodDetailContainer extends StatelessWidget {
  PetfoodDetailContainer({super.key});
  var screen_controller = Get.put(ScreenController());
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Container(
                  width: 200.w,
                  height: 30.h,
                  decoration: BoxDecoration(color: grey_color),
                  child: Center(child: Text(screen_controller.petfood_detail_data['name'])),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      color: grey_color,
                      child: Image.asset('assets/images/A000001.png'),
                    ),
                    SizedBox(width: 50.w),
                    Column(
                      children: [Text('사료 정보들')],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          InkWell(
            child: Icon(
              Icons.cancel,
              size: 30.w,
            ),
            onTap: () {
              screen_controller.set_petfood_detail_container();
            },
          ),
        ],
      ),
    );
  }
}
