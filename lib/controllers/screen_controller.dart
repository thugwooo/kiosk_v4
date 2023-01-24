import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/data/petfood.dart';
import 'package:kiosk_v4/data/screen.dart';

class ScreenController extends GetxController {
  var user_controller = Get.put(UserController());
  RxInt screen_index = ScreenState.main_screen.index.obs;
  RxInt bottom_navi_index = 0.obs;
  RxBool grey_background = false.obs;
  RxBool petfood_detail_container = false.obs;
  RxMap petfood_detail_data = {}.obs;
  RxBool search_container = false.obs;
  RxString search_text = ''.obs;
  var search_petfood = [];
  RxInt search_petfood_length = 0.obs;
  RxInt pop_category_index = 0.obs;
  RxInt sort_index = 0.obs;

  bool is_selected_bottom_navi_index(index) {
    return index == bottom_navi_index.value;
  }

  bool show_speech_bubble() {
    return speech_bubble.indexOf(screen_index.value) != -1;
  }

  void set_screen_index(index) {
    screen_index(index);
  }

  void set_navi_index(index) {
    screen_index(index);
    bottom_navi_index(index);
  }

  void set_search_container() {
    search_container(!search_container.value);
    set_background();
  }

  void set_search_text(value) {
    search_text(value);

    set_search_petfood();
  }

  void set_search_petfood_length() {
    search_petfood_length(search_petfood.length);
  }

  void set_petfood_detail_container({petfood_data}) {
    petfood_detail_container(!petfood_detail_container.value);
    petfood_detail_data(petfood_data);
    set_background();
  }

  void set_background() {
    if (petfood_detail_container.value == false && search_container.value == false) {
      grey_background(false);
    } else {
      grey_background(true);
    }
  }

  void set_pop_category_index(index) {
    pop_category_index(index);
  }

  void set_sort_index(index) {
    sort_index(index);
    // TODO: 가격 데이터 정리되면 정렬 시작
  }

  bool is_selected_pop_category_index(index) {
    return pop_category_index.value == index;
  }

  bool search_text_bool() {
    return search_text.value != '';
  }

  bool is_selected_sort_index(index) {
    return sort_index.value == index;
  }

  void set_search_petfood() {
    var temp = [];
    for (var petfood_index = 0; petfood_index < petfood_list[user_controller.user_info['pet']].length; petfood_index++) {
      // print(petfood_list[petfood_index]['name'].toString().contains(search_text.value));
      if (petfood_list[user_controller.user_info['pet']][petfood_index]['name'].toString().contains(search_text.value)) {
        temp.add(petfood_list[user_controller.user_info['pet']][petfood_index]);
      } else if (petfood_list[user_controller.user_info['pet']][petfood_index]['brand'].toString().contains(search_text.value)) {
        temp.add(petfood_list[user_controller.user_info['pet']][petfood_index]);
      }
    }
    search_petfood = temp;
    set_search_petfood_length();
  }
}
