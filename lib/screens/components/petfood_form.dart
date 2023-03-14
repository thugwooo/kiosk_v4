import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

class PetfoodForm extends StatelessWidget {
  PetfoodForm({super.key, required this.petfood_data, this.width, this.height, this.img_size, this.top_space, this.bottom_space, this.curation = false});
  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());
  var petfood_data;
  var width, height, img_size, top_space, bottom_space;
  var price = NumberFormat('###,###,###,###');
  bool curation;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: curation ? health_background_color[user_controller.health_ranking_index(curation: curation, petfood_data: petfood_data)] : grey_0,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 1.0.w,
                  spreadRadius: 1.0.w,
                  offset: Offset(1.w, 1.h),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: top_space),
                Image.asset('assets/images/' + petfood_data['eng_name'] + '.png', width: img_size),
                SizedBox(height: bottom_space),
                Text(petfood_data['brand'].toString(), style: TextStyle(fontSize: 9.sp)),
                Text(petfood_data['short_name'].toString(), style: TextStyle(fontSize: 9.sp)),
                Text(petfood_data['weight'].toString() + ' / ' + price.format(petfood_data['retail_price']) + '원', style: TextStyle(fontSize: 9.sp)),
              ],
            ),
          ),
          Visibility(
            visible: user_controller.visible_ranking(curation: curation, petfood_data: petfood_data),
            child: Positioned(
              left: 5.w,
              top: 5.h,
              child: Container(
                width: 15.w,
                height: 15.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: health_border_color[user_controller.health_ranking_index(curation: curation, petfood_data: petfood_data)]),
                child: Center(child: Text('${user_controller.health_ranking_index(curation: curation, petfood_data: petfood_data) + 1}', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        screen_controller.set_petfood_detail_container(petfood_data: petfood_data);
      },
    );
  }
}
