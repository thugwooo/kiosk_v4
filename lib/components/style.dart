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
final grey_0 = Color.fromRGBO(248, 249, 250, 1);
final grey_1 = Color.fromRGBO(241, 243, 245, 1);
final grey_2 = Color.fromRGBO(233, 236, 239, 1);
final grey_color = Color.fromRGBO(229, 229, 229, 1);
final color_128 = Color.fromRGBO(128, 128, 128, 1);
var health_border_color = [Colors.red, Colors.green, Colors.blue, Colors.white];
var health_background_color = [Color.fromRGBO(247, 226, 226, 1), Color.fromRGBO(213, 247, 236, 1), Color.fromRGBO(194, 228, 239, 1), grey_0];
final black_border = BoxDecoration(color: grey_0, border: Border.all(color: Colors.black, width: 1.w), borderRadius: BorderRadius.circular(5.w));
final curation_subtitle_style = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
final curation_contents_style = TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500);
final curation_selected_contents_style = TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500, color: Colors.white);

final pet_container_style = BoxDecoration(border: Border.all(color: main_color, width: 1.w), borderRadius: BorderRadius.circular(15.w), color: Colors.white);

final animated_velocity = 300;
