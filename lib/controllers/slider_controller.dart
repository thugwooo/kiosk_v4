import 'package:get/get.dart';

class SliderController extends GetxController {
  RxInt current_page_index = 0.obs;

  void set_current_page_index(index) {
    current_page_index(index);
  }

  bool is_current_page_index(index) {
    return current_page_index.value == index;
  }
}
