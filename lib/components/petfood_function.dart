import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

var user_controller = Get.put(UserController());
var screen_controller = Get.put(ScreenController());

enum SortState { sales, dsc_price, asc_price, dsc_kibble, asc_kibble }

bool pop_cate_filter({petfood_data, sort_text}) {
  // var sort_text = popular_category_text[user_controller.user_info['pet'].value][screen_controller.sort_index.value];
  var temp = petfood_data['pop_category'].indexOf(sort_text);

  return temp != -1;
}

void sort_petfood({sort_index, petfood_list}) {
  if (sort_index == SortState.sales.index) {
    // 판매량
  } else if (sort_index == SortState.asc_price.index) {
    // 가격 내림차순
    petfood_list[user_controller.user_info['pet'].value].sort((a, b) => (a['retail_price'] as int).compareTo(b['retail_price'] as int));
    print(petfood_list[user_controller.user_info['pet'].value][0]);
  } else if (sort_index == SortState.dsc_price.index) {
    petfood_list[user_controller.user_info['pet'].value].sort((a, b) => (b['retail_price'] as int).compareTo(a['retail_price'] as int));
    print(petfood_list[user_controller.user_info['pet'].value][0]);
  } else if (sort_index == SortState.asc_kibble.index) {
    petfood_list[user_controller.user_info['pet'].value].sort((a, b) => (a['kibble'] as int).compareTo(b['kibble'] as int));
    print(petfood_list[user_controller.user_info['pet'].value][0]);
  } else if (sort_index == SortState.dsc_kibble.index) {
    petfood_list[user_controller.user_info['pet'].value].sort((a, b) => (b['kibble'] as int).compareTo(a['kibble'] as int));
    print(petfood_list[user_controller.user_info['pet'].value][0]);
  }
  user_controller.set_petfood_list_length();
}

void sort_curation_petfood({sort_index, petfood_list}) {
  print(petfood_list[0]['retail_price'].runtimeType);
  if (sort_index == SortState.sales.index) {
    // 판매량
  } else if (sort_index == SortState.asc_price.index) {
    // 가격 내림차순
    petfood_list.sort((a, b) => (a['retail_price'] as int).compareTo(b['retail_price'] as int));
  } else if (sort_index == SortState.dsc_price.index) {
    petfood_list.sort((a, b) => (b['retail_price'] as int).compareTo(a['retail_price'] as int));
  } else if (sort_index == SortState.asc_kibble.index) {
    petfood_list.sort((a, b) => (a['kibble'] as int).compareTo(b['kibble'] as int));
  } else if (sort_index == SortState.dsc_kibble.index) {
    petfood_list.sort((a, b) => (b['kibble'] as int).compareTo(a['kibble'] as int));
  }
  print(petfood_list[0]);
}
