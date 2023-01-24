import 'package:get/get.dart';

class UserController extends GetxController {
  RxMap user_info = {
    'member_id': ''.obs,
    'pet': 0.obs,
    'name': ''.obs,
    'breed': '선택'.obs,
    'birth_year': '년'.obs,
    'birth_month': '월'.obs,
    'birth_day': '일'.obs,
    'sex': 0.obs,
    'neutering': 0.obs,
    'bcs': 0.obs,
    'show_alg': 1.obs,
    'alg': [].obs,
    'alg_sub': [].obs,
    'health': [].obs,
    'weight': "".obs,
  }.obs;

  bool is_selected_user_info({text, value}) {
    return user_info[text].value == value;
  }

  void set_user_info({text, value}) {
    user_info[text](value);
  }
}
