import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/basic_function.dart';
import 'package:kiosk_v4/controllers/filter_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/data/petfood.dart';
import 'package:kiosk_v4/data/screen.dart';

class ScreenController extends GetxController {
  var filter_controller = Get.put(FilterController());
  var scroll_controller = ScrollController().obs;
  var user_controller = Get.put(UserController());
  // RxInt screen_index = ScreenState.main_screen.index.obs;
  // RxInt bottom_navi_index = ScreenState.main_screen.index.obs;
  RxInt screen_index = ScreenState.curation_pet_screen.index.obs;
  RxInt bottom_navi_index = ScreenState.curation_main_screen.index.obs;
  RxBool grey_background = false.obs;
  RxBool petfood_detail_container = false.obs;
  RxMap petfood_detail_data = {}.obs;
  RxBool search_container = false.obs;
  RxString search_text = ''.obs;
  var search_petfood = [];
  RxInt search_petfood_length = 0.obs;
  RxInt pop_category_index = 0.obs;
  RxInt sort_index = 0.obs;
  int _count = 0;
  late Timer _timer;
  void start_timer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _count++;
      print(_count);
      if (_count == 30) {
        _count = 0;
        set_navi_index(ScreenState.main_screen.index);
      }
    });
  }

  void cancel_timer() {
    _timer.cancel();
  }

  void restart_timer() {
    _count = 0;
  }

  void scroll_up() {
    scroll_controller.value.animateTo(0, duration: Duration(microseconds: 100), curve: Curves.ease);
  }

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
    if ([ScreenState.curation_input_screen.index, ScreenState.curation_pet_screen.index, ScreenState.curation_recommend_petfood_screen.index, ScreenState.curation_record_petfood_screen.index]
        .contains(screen_index.value)) {
      Get.dialog(AlertDialog(
        title: Text('현재 화면을 벗어나실 경우 정보가 초기화 됩니다. 이동하시겠습니까?'),
        actions: [
          TextButton(
            child: Text('예'),
            onPressed: () {
              Get.back();
              set_screen_index(index);
              bottom_navi_index(index);
              filter_controller.change_pet();
              user_controller.add_new_pet_button({'member_id': ''});
            },
          ),
          TextButton(
            child: Text('아니오'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ));
    } else {
      set_screen_index(index);
      bottom_navi_index(index);
    }
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

    refresh();
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

  String set_life_stage_text() {
    String return_text = '';

    if (petfood_detail_data['life_stage'].length == 3) {
      return_text = '무관';
    } else {
      return_text = list_to_str(petfood_detail_data['life_stage']);
    }
    return return_text;
  }

  String set_size_text() {
    if (petfood_detail_data['size'].length == 5) return '무관';
    if (petfood_detail_data['size'].length == 3) return petfood_detail_data['size'][0] + ' ~ ' + petfood_detail_data['size'][2];

    return list_to_str(petfood_detail_data['size']);
  }

  String set_main_ingredient() {
    return petfood_detail_data['main_ingredient'].length > 2
        ? petfood_detail_data['main_ingredient'][0] + ', ' + petfood_detail_data['main_ingredient'][1]
        : list_to_str(petfood_detail_data['main_ingredient']);
  }

  void set_search_petfood() {
    var temp = [];
    for (var petfood_index = 0; petfood_index < petfood_list[user_controller.user_info['pet'].value].length; petfood_index++) {
      // print(petfood_list[petfood_index]['name'].toString().contains(search_text.value));
      if (petfood_list[user_controller.user_info['pet'].value][petfood_index]['name'].toString().contains(search_text.value)) {
        temp.add(petfood_list[user_controller.user_info['pet'].value][petfood_index]);
      } else if (petfood_list[user_controller.user_info['pet'].value][petfood_index]['brand'].toString().contains(search_text.value)) {
        temp.add(petfood_list[user_controller.user_info['pet'].value][petfood_index]);
      } else if (petfood_list[user_controller.user_info['pet'].value][petfood_index]['short_name'].toString().contains(search_text.value)) {
        temp.add(petfood_list[user_controller.user_info['pet'].value][petfood_index]);
      }
    }
    search_petfood = temp;
    set_search_petfood_length();
  }
}
