import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/basic_function.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/data/detail_petfood.dart';

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
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
            width: 500.w,
            height: 350.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _header_info(),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.only(
                    left: 30.w,
                    top: 30.h,
                  ),
                  width: 440.w,
                  height: 200.h,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: grey_color),
                  child: Column(
                    children: [
                      _main_info_1(),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Container(
                            width: 90.w,
                            height: 50.h,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.w)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle, size: 35.w),
                                SizedBox(width: 10.w),
                                Text(screen_controller.petfood_detail_data['kibble'].toString() + 'mm', style: TextStyle(fontSize: 11.sp)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('(%)', style: TextStyle(fontSize: 8.sp)),
                              Container(
                                width: 285.w,
                                child: Table(
                                  border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(
                                      children: [
                                        for (var nutrients_index = 0; nutrients_index < 6; nutrients_index++)
                                          Container(
                                            color: main_color,
                                            height: 25.h,
                                            child: Center(
                                              child: Text(nutrients_kor[nutrients_index], style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                                            ),
                                          ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        for (var nutrients_index = 0; nutrients_index < 5; nutrients_index++)
                                          Container(
                                            color: Colors.white,
                                            height: 25.h,
                                            child: Center(
                                              child: Text(nutrients_text[nutrients_index], style: TextStyle(color: main_color, fontSize: 10.sp)),
                                            ),
                                          ),
                                        Container(
                                          color: Colors.white,
                                          height: 25.h,
                                          child: Center(
                                            child: Text((screen_controller.petfood_detail_data['kcal'] * 10).toInt().toString(), style: TextStyle(color: main_color, fontSize: 10.sp)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
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

  Row _main_info_1() {
    return Row(
      children: [
        Container(
          height: 68.h,
          decoration: test_line,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var hash_index = 0; hash_index < screen_controller.petfood_detail_data['hash'].length; hash_index++)
                Container(
                  width: 90.w,
                  child: Text('#  ' + screen_controller.petfood_detail_data['hash'][hash_index], style: TextStyle(fontSize: 11.sp, color: main_color)),
                ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        _main_info_container(title: '권장연령', info: list_to_str(screen_controller.petfood_detail_data['life_stage'])),
        SizedBox(width: 5.w),
        _main_info_container(title: '권장사이즈', info: list_to_str(screen_controller.petfood_detail_data['size'])),
        SizedBox(width: 5.w),
        _main_info_container(title: '사료형태', info: list_to_str(screen_controller.petfood_detail_data['shape'])),
        SizedBox(width: 5.w),
        _main_info_container(title: '주 단백질원', info: list_to_str(screen_controller.petfood_detail_data['main_ingredient'])),
      ],
    );
  }

  Container _main_info_container({title, info}) {
    return Container(
      width: 68.w,
      height: 68.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w), color: Colors.white),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Icon(
            Icons.check,
            size: 10.w,
            color: Color.fromRGBO(0, 188, 165, 1),
          ),
          Text('${title}', style: TextStyle(fontSize: 11.sp, color: Color.fromRGBO(128, 128, 128, 1))),
          Text(
            '${info}',
            style: TextStyle(fontSize: 10.sp),
          )
        ],
      ),
    );
  }

  Row _header_info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 95.w,
              height: 95.h,
              decoration: test_line,
              child: Image.asset(
                'assets/images/A000001.png',
                width: 95.w,
              ),
            ),
            Container(
              height: 95.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(screen_controller.petfood_detail_data['brand'], style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color.fromRGBO(150, 151, 153, 1))),
                      Text(screen_controller.petfood_detail_data['name'], style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: main_color)),
                    ],
                  ),
                  Text('${screen_controller.petfood_detail_data['weight']} | ${screen_controller.petfood_detail_data['retail_price']}', style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: test_line,
              child: Center(child: Text('qr코드')),
            ),
          ],
        ),
      ],
    );
  }
}
