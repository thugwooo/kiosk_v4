import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  RxInt current_page_index = 0.obs;
  var scroll = ScrollController().obs;
  RxBool show_pet_info = true.obs;
  @override
  void onInit() {
    super.onInit();
    scroll.value.addListener(() {
      if (scroll.value.position.pixels < 10)
        show_pet_info(true);
      else
        show_pet_info(false);
    });
  }

  void set_current_page_index(index) {
    current_page_index(index);
  }

  bool is_current_page_index(index) {
    return current_page_index.value == index;
  }
}
