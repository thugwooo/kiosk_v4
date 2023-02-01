import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final main_width = 600.w;
final main_height = 450.h;

final curation_box_height = 25.h;
final curation_title_width = 60.w;
final curation_container_width = 250.w;
final small_container_width = 80.w;
final curation_row_width = 310.w;
final test_line = BoxDecoration(border: Border.all(color: main_color));
final white_box_deco = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.w));
final louis_box_deco = BoxDecoration(color: main_color, borderRadius: BorderRadius.circular(5.w));
final main_color = Color.fromRGBO(0, 26, 94, 1);
final mint_color = Color.fromRGBO(137, 241, 207, 1);
final background_color = Color.fromRGBO(228, 239, 234, 1);
final background_blue_color = Color.fromRGBO(179, 196, 226, 0.31);
final grey_color = Color.fromRGBO(229, 229, 229, 1);
final color_128 = Color.fromRGBO(128, 128, 128, 1);
final black_border = BoxDecoration(border: Border.all(color: Colors.black, width: 2.w), borderRadius: BorderRadius.circular(10.w));
final curation_subtitle_style = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
final curation_contents_style = TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500);
final curation_selected_contents_style = TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500, color: Colors.white);

final pet_container_style = BoxDecoration(border: Border.all(color: main_color, width: 1.w), borderRadius: BorderRadius.circular(15.w), color: Colors.white);

final animated_velocity = 300;
