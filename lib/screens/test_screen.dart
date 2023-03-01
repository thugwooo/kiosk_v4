import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../data/category.dart';

// class PopularCategoryScreen extends StatelessWidget {
//   PopularCategoryScreen({super.key});
//   var screen_controller = Get.put(ScreenController());
//   var user_controller = Get.put(UserController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 30.h),

//       child: Column(
//         children: [
//           _cate_row_form(title: '연령', s_index: 0, e_index: 3),
//           SizedBox(height: 40.w),
//           _cate_row_form(title: '원재료', s_index: 3, e_index: 6),
//           SizedBox(height: 40.w),
//           _cate_row_form(title: '기능', s_index: 6, e_index: 8),
//         ],
//       ),

//       // Wrap(
//       //   children: [
//       //     for (var index = 0; index < popular_category_text[user_controller.user_info['pet'].value].length; index++)
//       //       Padding(
//       //         padding: EdgeInsets.only(right: 30.w, bottom: 20.h),
//       //         child: _category_container_form(index),
//       //       )
//       //   ],
//       // ),
//     );
//   }

//   Widget _cate_row_form({title, s_index, e_index}) {
//     return Row(
//       children: [
//         Container(width: 145.w, child: Center(child: Text('$title', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)))),
//         for (var index = s_index; index < e_index; index++) Container(margin: EdgeInsets.only(right: 20.w), child: _category_container_form(index)),
//       ],
//     );
//   }

//   InkWell _category_container_form(index) {
//     return InkWell(
//       child: Obx(
//         () => Container(
//           width: 92.w,
//           height: 58.h,
//           decoration: BoxDecoration(
//             color: grey_0,
//             borderRadius: BorderRadius.circular(5.w),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.7),
//                 blurRadius: 1.0.w,
//                 spreadRadius: 1.0.w,
//                 offset: Offset(1.w, 1.h),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               '${popular_category_text[user_controller.user_info["pet"].value][index]}',
//               style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         screen_controller.set_screen_index(4);
//         screen_controller.set_pop_category_index(index);
//       },
//     );
//   }
// }
