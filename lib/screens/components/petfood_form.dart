import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

class PetfoodForm extends StatelessWidget {
  PetfoodForm({super.key, required this.petfood_data, this.width, this.height, this.img_size, this.top_space, this.bottom_space});
  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());
  var petfood_data;
  var width, height, img_size, top_space, bottom_space;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          children: [
            SizedBox(height: top_space),
            Image.asset('assets/images/' + petfood_data['eng_name'] + '.png', width: img_size),
            SizedBox(height: bottom_space),
            Text(petfood_data['brand'].toString(), style: TextStyle(fontSize: 9.sp)),
            Text(petfood_data['short_name'].toString(), style: TextStyle(fontSize: 9.sp)),
            Text(petfood_data['weight'].toString() + ' / ' + petfood_data['retail_price'].toString() + '원', style: TextStyle(fontSize: 9.sp)),
          ],
        ),
      ),
      onTap: () {
        screen_controller.set_petfood_detail_container(petfood_data: petfood_data);
      },
    );
  }
}
