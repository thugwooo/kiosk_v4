import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/data/category.dart';

var user_controller = Get.put(UserController());
var screen_controller = Get.put(ScreenController());

bool pop_cate_filter({petfood_data, sort_text}) {
  // var sort_text = popular_category_text[user_controller.user_info['pet'].value][screen_controller.sort_index.value];
  var temp = petfood_data['pop_category'].indexOf(sort_text);
  print(petfood_data['pop_category']);

  return temp != -1;
}
