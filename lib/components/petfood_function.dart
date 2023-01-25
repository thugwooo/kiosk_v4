import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

var user_controller = Get.put(UserController());
var screen_controller = Get.put(ScreenController());

bool pop_cate_filter({petfood_data, sort_text}) {
  // var sort_text = popular_category_text[user_controller.user_info['pet'].value][screen_controller.sort_index.value];
  var temp = petfood_data['pop_category'].indexOf(sort_text);

  return temp != -1;
}

void sort_petfood(sort_index) {
  if (sort_index == 0) {
    // 판매량
  } else if (sort_index == 1) {
    // 가격 내림차순
    // petfood_list.sort((a, b) => int.parse(a['retail_price'][0]).compareTo(int.parse(b['retail_price'][0])));
  } else if (sort_index == 2) {}
}
