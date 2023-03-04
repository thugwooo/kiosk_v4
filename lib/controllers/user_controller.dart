import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/rest+api.dart';
import 'package:kiosk_v4/data/petfood.dart';

import '../components/basic_function.dart';
import '../components/petfood_function.dart';
import '../data/curation.dart';

class UserController extends GetxController {
  RxMap user_info = {
    'member_id': '01098701720'.obs,
    'pet': 0.obs,
    'name': ''.obs,
    'breed': '선택'.obs,
    'birth_year': '년'.obs,
    'birth_month': '월'.obs,
    'birth_day': '일'.obs,
    'sex': 2.obs,
    'neutering': 2.obs,
    'bcs': 1.obs,
    'show_alg': 2.obs,
    'alg': [].obs,
    'alg_sub': [].obs,
    'health': ['', '', ''].obs,
    'weight': "".obs,
  }.obs;
  RxString phone_number = ''.obs;
  RxBool agreement = false.obs;
  RxInt petfood_list_length = petfood_list[0].length.obs;
  var pet_list = [];
  RxInt pet_length = 0.obs;
  RxInt selected_pet_index = 0.obs;
  RxInt sort_index = 0.obs;
  var curation_data = {}.obs;
  var curation_petfood = [];
  RxInt curation_petfood_length = 0.obs;
  var selected_petfood_list = [];
  RxInt selected_petfood_list_length = 0.obs;
  var scroll_controller = ScrollController().obs;

  void remove_health_ranking(index) {
    user_info['health'][index] = '';
  }

  void set_health_ranking({value}) {
    int index = user_info['health'].indexOf(value);
    if (index != -1) {
      user_info['health'][index] = '';
    } else {
      for (var ranking_index = 0; ranking_index < 3; ranking_index++) {
        if (user_info['health'][ranking_index] == '') {
          user_info['health'][ranking_index] = value;
          break;
        }
      }
    }
  }

  dynamic health_ranking_index({curation, petfood_data}) {
    if (curation) {
      return petfood_data['health_ranking'];
    }
    return 0;
  }

  bool visible_ranking({curation, petfood_data}) {
    if (curation) {
      return true;
    }
    return false;
  }

  void add_number_phone_number(index) {
    if (phone_number.value.length < 8) {
      phone_number.value += index.toString();
    }
    print(phone_number);
  }

  void back_space_phone_number() {
    phone_number.value = phone_number.value.substring(0, phone_number.value.length - 1);
  }

  String get_phone_number() {
    if (phone_number.value.length > 3) {
      return phone_number.value.substring(0, 4) + ' - ' + phone_number.value.substring(4, phone_number.value.length);
    } else {
      return phone_number.value;
    }
  }

  bool phone_number_validator() {
    if (phone_number.value.length == 8) {
      return true;
    }

    return false;
  }

  void set_petfood_list_length() {
    petfood_list_length(petfood_list[user_info['pet'].value].length);
    petfood_list_length++;
    petfood_list_length--;
  }

  String pet_age_sex_data({index}) {
    var str_data = '';
    str_data += pet_list[index]['age'].toString() + '살 ';
    str_data += pet_list[index]['sex'] == '0' ? '수컷' : '암컷';
    return str_data;
  }

  dynamic user_exist() async {
    var response = await post_data(url: 'user-exist/', data: {'member_id': user_info['member_id'].value});
    return response;
  }

  bool is_selected_user_info({text, index}) {
    return user_info[text].value == index;
  }

  bool is_selected_list_button({text, value}) {
    if (user_info[text].indexOf(value) != -1) {
      return true;
    }
    return false;
  }

  void set_user_info({text, value}) {
    user_info[text](value);
  }

  void set_agreement() {
    agreement(!agreement.value);
  }

  void set_user_list_info({text, value}) {
    if (user_info[text].indexOf(value) != -1) {
      user_info[text].remove(value);
    } else {
      user_info[text].add(value);
    }
  }

  void set_pet_list() {
    post_data(url: 'pet-info/', data: {'member_id': user_info['member_id'].value}).then((value) {
      pet_list = value;
      set_pet_length();
    });
  }

  void set_pet_length() {
    pet_length(pet_list.length);
  }

  void add_new_pet_button(member_id) {
    set_whole_user_info({
      'member_id': member_id,
      'name': '',
      'breed': '선택',
      'birth_year': '년',
      'birth_month': '월',
      'birth_day': '일',
      'sex': '2',
      'neutering': '2',
      'bcs': '3',
      'show_alg': '2',
      'alg': [],
      'alg_sub': [],
      'health': ['', '', ''],
      'weight': "",
    });
  }

  void set_user_info_button(index) {
    set_whole_user_info(pet_list[index]);
  }

  void modify_button() {
    set_whole_user_info(curation_data);
  }

  void recommend_button(index) {
    set_selected_pet_index(index);
  }

  void delete_button(index) {
    post_data(url: 'pet-delete/', data: pet_list[index]).then(
      (value) {
        set_pet_list();
      },
    );
  }

  void set_selected_pet_index(index) {
    selected_pet_index(index);
  }

  void set_whole_user_info(data) {
    user_info['member_id'](data['member_id']);
    user_info['name'](data['name']);
    user_info['breed'](data['breed']);
    user_info['birth_year'](data['birth_year']);
    user_info['birth_month'](data['birth_month']);
    user_info['birth_day'](data['birth_day']);
    user_info['sex'](int.parse(data['sex']));
    user_info['neutering'](int.parse(data['neutering']));
    user_info['bcs'](int.parse(data['bcs']));
    user_info['alg'](str_to_list(data['alg']));
    user_info['show_alg'](user_info['alg'].length > 0 ? 0 : 1);
    user_info['alg_sub'](str_to_list(data['alg_sub']));
    var health_data = str_to_list(data['health']);
    for (var index = 0; index < health_data.length; index++) {
      user_info['health'][index] = health_data[index].trim();
    }
    user_info['weight'](data['weight']);
  }

  void get_curation_petfood() {
    post_data(url: 'curation-kiosk/', data: pet_list[selected_pet_index.value]).then((response) {
      curation_data(response['curation_data']);
      curation_data['algs'] = str_to_list([...curation_data['alg'], ...curation_data['alg_sub']]);
      curation_petfood = response['dsc_price'];
      for (var c_index = 0; c_index < curation_petfood.length; c_index++) {
        for (var m_index = 0; m_index < petfood_list[user_info['pet'].value].length; m_index++) {
          if (curation_petfood[c_index]['name'] == petfood_list[user_info['pet'].value][m_index]['name']) {
            curation_petfood[c_index]['short_name'] = petfood_list[user_info['pet'].value][m_index]['short_name'];
          }
        }
      }
      for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
        curation_petfood[p_index]['health_ranking'] = 0;
      }
      // set_health_ranking_version_1();
      set_health_ranking_version_2();

      refresh();
      sort_curation_petfood(sort_index: 0, petfood_list: user_controller.curation_petfood);
      set_curation_petfood_length();
      // for (var index = 0; index < curation_petfood.length; index++) {
      //   print(curation_petfood[index]['name'] + curation_petfood[index]['health_ranking'].toString());
      // }
    });
    set_curation_petfood_length();
  }

  void set_health_ranking_version_1() {
    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      curation_petfood[p_index]['used'] = false;
      curation_petfood[p_index]['health_ranking'] = 3;
    }
    for (var h_index = 0; h_index < user_info['health'].length; h_index++) {
      for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
        if (curation_petfood[p_index]['health_1'] == user_info['health'][h_index] && !curation_petfood[p_index]['used']) {
          curation_petfood[p_index]['health_ranking'] = h_index;
          curation_petfood[p_index]['used'] = true;
        }
      }
      if (curation_petfood.where((value) => value['health_ranking'] == h_index).length == 0) {
        print('11');
        for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
          if (curation_petfood[p_index]['health_2'] == user_info['health'][h_index] && !curation_petfood[p_index]['used']) {
            curation_petfood[p_index]['health_ranking'] = h_index;
            curation_petfood[p_index]['used'] = true;
          }
        }
      }
      if (curation_petfood.where((value) => value['health_ranking'] == h_index).length == 0) {
        for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
          if (curation_petfood[p_index]['health_3'] == user_info['health'][h_index] && !curation_petfood[p_index]['used']) {
            curation_petfood[p_index]['health_ranking'] = h_index;
            curation_petfood[p_index]['used'] = true;
          }
        }
      }
    }
  }

  void set_health_ranking_version_2() {
    var coefficient = [
      [6, 4, 2],
      [3, 2, 1],
      [2, 1, 0]
    ];

    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      curation_petfood[p_index]['health_ranking'] = 0;
    }
    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      for (var h_index = 0; h_index < curation_data['health'].length; h_index++) {
        for (var ch_index = 0; ch_index < 3; ch_index++) {
          if (curation_data['health'][h_index] != '') {
            if (curation_data['health'][h_index] == curation_petfood[p_index]['health_${ch_index + 1}']) {
              curation_petfood[p_index]['health_ranking'] += (3 - h_index) * coefficient[h_index][ch_index];
              // print(h_index.toString() + '     ' + ch_index.toString() + '   ' + curation_data['health'][h_index]);
              // print(curation_petfood[p_index]['name'] + curation_petfood[p_index]['health_ranking'].toString());
            }
          }
        }
      }
    }
  }

  void set_curation_petfood_length() {
    curation_petfood_length--;
    curation_petfood_length++;
    curation_petfood_length(curation_petfood.length);
  }

  void set_sort_index(index) {
    sort_index(index);
  }

  String explain_text() {
    var text = '';
    if (curation_data['pet'] == '0') {
      if (curation_data['life_stage'] == '퍼피') {
        text += pet_explain_text_list[0];
      } else if (curation_data['life_stage'] == '어덜트') {
        if (curation_data['bcs'] != '2') {
          text += pet_explain_text_list[1];
        } else {
          text += pet_explain_text_list[2];
        }
      } else {
        if (curation_data['bcs'] != '2') {
          text += pet_explain_text_list[3];
        } else {
          text += pet_explain_text_list[4];
        }
      }
    } else {
      if (curation_data['life_stage'] == '키튼') {
        text += pet_explain_text_list[5];
      } else if (curation_data['life_stage'] == '어덜트') {
        if (curation_data['bcs'] != '2') {
          text += pet_explain_text_list[6];
        } else {
          text += pet_explain_text_list[7];
        }
      } else {
        if (curation_data['bcs'] != '2') {
          text += pet_explain_text_list[8];
        } else {
          text += pet_explain_text_list[9];
        }
      }
    }
    return text;
  }

  void get_selected_petfood() {
    post_data(url: 'get-petfood/', data: {
      'member_id': pet_list[selected_pet_index.value]['member_id']['member_id'],
      'name': pet_list[selected_pet_index.value]['name'],
    }).then((response) {
      print(response);
      selected_petfood_list = str_to_list(response['petfood']);
      set_selected_petfood_list_length();
    });
    set_selected_petfood_list_length();
  }

  void set_selected_petfood_list(petfood_name) {
    if (selected_petfood_list.indexOf(petfood_name) == -1) {
      selected_petfood_list.add(petfood_name);
    } else {
      selected_petfood_list.remove(petfood_name);
    }
    set_selected_petfood_list_length();
  }

  void set_selected_petfood_list_length() {
    selected_petfood_list_length(selected_petfood_list.length);
  }

  void post_selected_petfood() {
    post_data(url: 'set-petfood/', data: {
      'member_id': pet_list[selected_pet_index.value]['member_id']['member_id'],
      'name': pet_list[selected_pet_index.value]['name'],
      'petfood': selected_petfood_list,
    }).then((response) {
      print(response);
    });
  }

  dynamic input_check_form() {
    var return_data = {'scroll': 0.0, 'dialog_text': ''};
    if (user_info['health'].contains('')) {
      return_data['dialog_text'] = '건강 관리를 채워주세요.';
      return_data['scroll'] = 360.h;
    }
    if (user_info['show_alg'].value == 2) {
      return_data['dialog_text'] = '알러지 여부를 선택해주세요';
      return_data['scroll'] = 320.h;
    }
    if (user_info['weight'].value == '') {
      return_data['dialog_text'] = '몸무게를 채워주세요';
      return_data['scroll'] = 240.h;
    }
    if (user_info['neutering'].value == 2) {
      return_data['dialog_text'] = '중성화 여부를 선택해주세요.';
      return_data['scroll'] = 200.h;
    }
    if (user_info['sex'].value == 2) {
      return_data['dialog_text'] = '성별을 선택해주세요.';
      return_data['scroll'] = 160.h;
    }
    if (user_info['birth_year'].value == '년' || user_info['birth_month'].value == '월' || user_info['birth_day'].value == '') {
      return_data['dialog_text'] = '생년월일을 선택해주세요.';
      return_data['scroll'] = 120.h;
    }
    if (user_info['pet'].value == 0) {
      if (!dog_breed.contains(user_info['breed'].value)) {
        return_data['dialog_text'] = '견종을 선택해주세요.';
        return_data['scroll'] = 80.h;
      }
    } else {
      if (!cat_breed.contains(user_info['breed'].value)) {
        return_data['dialog_text'] = '묘종을 선택해주세요.';
        return_data['scroll'] = 80.h;
      }
    }
    if (user_info['name'].value == '') {
      return_data['dialog_text'] = '이름을 채워주세요.';
      return_data['scroll'] = 40.h;
    }

    return return_data;
  }

  void scroll_up(position) {
    scroll_controller.value.animateTo(position, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}
