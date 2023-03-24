import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/rest+api.dart';
import 'package:kiosk_v4/data/constants.dart';
import 'package:kiosk_v4/data/petfood.dart';

import '../components/basic_function.dart';
import '../components/petfood_function.dart';
import '../components/secret.dart';
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
  RxBool loading = false.obs;

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
    if (curation && petfood_data['health_ranking'] < 3) {
      return true;
    }
    return false;
  }

  void add_number_phone_number(index) {
    if (phone_number.value.length < 8) {
      phone_number.value += index.toString();
    }
  }

  void back_space_phone_number() {
    phone_number.value = phone_number.value.substring(0, phone_number.value.length - 1);
  }

  String get_phone_number() {
    if (phone_number.value == '') return '1234 - 5678';
    if (phone_number.value.length > 3) {
      return phone_number.value.substring(0, 4) + ' - ' + phone_number.value.substring(4, phone_number.value.length);
    }
    return phone_number.value;
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
    user_info['member_id'](data['member_id']['member_id']);
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
    loading(false);
    post_data(url: 'curation-kiosk/', data: pet_list[selected_pet_index.value]).then((response) {
      curation_data(response['curation_data']);
      curation_data['algs'] = str_to_list([...curation_data['alg'], ...curation_data['alg_sub']]);
      curation_petfood = response['dsc_price'];
      print(curation_data);
      for (var c_index = 0; c_index < curation_petfood.length; c_index++) {
        for (var m_index = 0; m_index < petfood_list[user_info['pet'].value].length; m_index++) {
          if (curation_petfood[c_index]['name'] == petfood_list[user_info['pet'].value][m_index]['name']) {
            curation_petfood[c_index]['short_name'] = petfood_list[user_info['pet'].value][m_index]['short_name'];
          }
        }
      }

      set_health_ranking_version_3();

      // set_health_ranking_version_2();

      refresh();
      sort_curation_petfood(sort_index: 0, petfood_list: user_controller.curation_petfood);
      set_curation_petfood_length();
      // for (var index = 0; index < curation_petfood.length; index++) {
      //   print(curation_petfood[index]['name'] + curation_petfood[index]['health_ranking'].toString());
      // }
    });
    set_curation_petfood_length();
  }

  void set_health_ranking_version_3() {
    var health_ranking_1_list = [];
    var health_ranking_2_list = [];
    var health_ranking_3_list = [];
    var health_ranking_4_list = [];
    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      curation_petfood[p_index]['used'] = false;
      curation_petfood[p_index]['health_ranking'] = 3;
      curation_petfood[p_index]['health_ranking_point'] = 3.0;
    }
    for (var r_index = 1; r_index < 4; r_index++) {
      for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
        for (var h_index = 0; h_index < 3; h_index++) {
          if (curation_petfood[p_index]['health_${r_index}'] == '') continue;
          if (curation_petfood[p_index]['used']) continue;
          if (curation_data['health'][h_index] == '') continue;
          if (r_index > 1 && curation_petfood.where((value) => value['health_ranking'] == h_index).length >= 3) continue;

          if (curation_data['health'][h_index] == curation_petfood[p_index]['health_${r_index}']) {
            curation_petfood[p_index]['health_ranking'] = h_index;
            curation_petfood[p_index]['health_ranking_point'] = h_index.toDouble();
            curation_petfood[p_index]['used'] = true;
          }
        }
      }
    }
    // health_ranking_point
    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      if (curation_petfood[p_index]['life_stage'].length == 1) {
        if (curation_petfood[p_index]['life_stage'].contains(curation_data['life_stage'])) {
          curation_petfood[p_index]['health_ranking_point'] -= 0.5;
        }
      }
      if (curation_petfood[p_index]['size'].length < 5) {
        if (curation_petfood[p_index]['size'].contains(curation_data['size'])) {
          curation_petfood[p_index]['health_ranking_point'] -= 0.1;
        }
      }
    }
    curation_petfood.sort((a, b) => (a['health_ranking_point'] as double).compareTo(b['health_ranking_point'] as double));
    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      if (curation_petfood[p_index]['health_ranking'] == 0)
        health_ranking_1_list.add(curation_petfood[p_index]);
      else if (curation_petfood[p_index]['health_ranking'] == 1)
        health_ranking_2_list.add(curation_petfood[p_index]);
      else if (curation_petfood[p_index]['health_ranking'] == 2)
        health_ranking_3_list.add(curation_petfood[p_index]);
      else
        health_ranking_4_list.add(curation_petfood[p_index]);
    }

    health_ranking_1_list.sort(((a, b) => health_sub_sorting(a, b, 0)));
    health_ranking_2_list.sort(((a, b) => health_sub_sorting(a, b, 1)));
    health_ranking_3_list.sort(((a, b) => health_sub_sorting(a, b, 2)));

    // 오리젠, 나우 한 개씩만 남기고 제거
    var orijen_count = 0;
    var now_count = 0;
    for (var p_index = 0; p_index < health_ranking_1_list.length; p_index++) {
      if (health_ranking_1_list[p_index]['brand'] == '오리젠') {
        if (orijen_count > 0) {
          health_ranking_1_list[p_index]['health_ranking'] = 3;
          health_ranking_1_list[p_index]['health_ranking_point'] += 3;
        }
        orijen_count++;
      }
      if (health_ranking_1_list[p_index]['brand'] == '나우') {
        if (now_count > 0) {
          health_ranking_1_list[p_index]['health_ranking'] = 3;
          health_ranking_1_list[p_index]['health_ranking_point'] += 3;
        }
        now_count++;
      }
    }

    orijen_count = 0;
    now_count = 0;
    for (var p_index = 0; p_index < health_ranking_2_list.length; p_index++) {
      if (health_ranking_2_list[p_index]['brand'] == '오리젠') {
        if (orijen_count > 0) {
          health_ranking_2_list[p_index]['health_ranking'] = 3;
          health_ranking_2_list[p_index]['health_ranking_point'] += 3;
        }
        orijen_count++;
      }
      if (health_ranking_2_list[p_index]['brand'] == '나우') {
        if (now_count > 0) {
          health_ranking_2_list[p_index]['health_ranking'] = 3;
          health_ranking_2_list[p_index]['health_ranking_point'] += 3;
        }
        now_count++;
      }
    }

    orijen_count = 0;
    now_count = 0;
    for (var p_index = 0; p_index < health_ranking_3_list.length; p_index++) {
      if (health_ranking_3_list[p_index]['brand'] == '오리젠') {
        if (orijen_count > 0) {
          health_ranking_3_list[p_index]['health_ranking'] = 3;
          health_ranking_3_list[p_index]['health_ranking_point'] += 3;
        }
        orijen_count++;
      }
      if (health_ranking_3_list[p_index]['brand'] == '나우') {
        if (now_count > 0) {
          health_ranking_3_list[p_index]['health_ranking'] = 3;
          health_ranking_3_list[p_index]['health_ranking_point'] += 3;
        }
        now_count++;
      }
    }

    var r1_list = health_ranking_1_list.where((element) => element['brand'] == '지위픽').toList();
    if (r1_list.length > 1) {
      r1_list.sort((a, b) => -a['protein_dm'].compareTo(b['protein_dm']));
      for (var index = 1; index < r1_list.length; index++) {
        r1_list[index]['health_ranking'] = 3;
        r1_list[index]['health_ranking_point'] += 3;
      }
    }

    var r2_list = health_ranking_2_list.where((element) => element['brand'] == '지위픽').toList();
    if (r2_list.length > 1) {
      r2_list.sort((a, b) => -a['protein_dm'].compareTo(b['protein_dm']));
      for (var index = 1; index < r2_list.length; index++) {
        r2_list[index]['health_ranking'] = 3;
        r2_list[index]['health_ranking_point'] += 3;
      }
    }

    var r3_list = health_ranking_3_list.where((element) => element['brand'] == '지위픽').toList();
    if (r3_list.length > 1) {
      r3_list.sort((a, b) => -a['protein_dm'].compareTo(b['protein_dm']));
      for (var index = 1; index < r3_list.length; index++) {
        r3_list[index]['health_ranking'] = 3;
        r3_list[index]['health_ranking_point'] += 3;
      }
    }

    health_ranking_1_list.sort(((a, b) => health_sub_sorting(a, b, 0)));
    health_ranking_2_list.sort(((a, b) => health_sub_sorting(a, b, 1)));
    health_ranking_3_list.sort(((a, b) => health_sub_sorting(a, b, 2)));

    if (health_ranking_1_list.length > SHOW_CURATION_PETFOOD_NUMBER) {
      for (var p_index = SHOW_CURATION_PETFOOD_NUMBER; p_index < health_ranking_1_list.length; p_index++) {
        health_ranking_1_list[p_index]['health_ranking'] = 3;
        health_ranking_1_list[p_index]['health_ranking_point'] += 3;
        health_ranking_4_list.add(health_ranking_1_list[p_index]);
      }
      health_ranking_1_list.removeRange(SHOW_CURATION_PETFOOD_NUMBER, health_ranking_1_list.length);
    }

    if (health_ranking_2_list.length > SHOW_CURATION_PETFOOD_NUMBER) {
      for (var p_index = SHOW_CURATION_PETFOOD_NUMBER; p_index < health_ranking_2_list.length; p_index++) {
        health_ranking_2_list[p_index]['health_ranking'] = 3;
        health_ranking_2_list[p_index]['health_ranking_point'] += 2;
        health_ranking_4_list.add(health_ranking_2_list[p_index]);
      }
      health_ranking_2_list.removeRange(SHOW_CURATION_PETFOOD_NUMBER, health_ranking_2_list.length);
    }

    if (health_ranking_3_list.length > SHOW_CURATION_PETFOOD_NUMBER) {
      for (var p_index = SHOW_CURATION_PETFOOD_NUMBER; p_index < health_ranking_3_list.length; p_index++) {
        health_ranking_3_list[p_index]['health_ranking'] = 3;
        health_ranking_3_list[p_index]['health_ranking_point'] += 1;
        health_ranking_4_list.add(health_ranking_3_list[p_index]);
      }
      health_ranking_3_list.removeRange(SHOW_CURATION_PETFOOD_NUMBER, health_ranking_3_list.length);
    }

    for (var p_index = 0; p_index < health_ranking_1_list.length; p_index++) health_ranking_1_list[p_index]['health_ranking_point'] += 0.01 * p_index;
    for (var p_index = 0; p_index < health_ranking_2_list.length; p_index++) health_ranking_2_list[p_index]['health_ranking_point'] += 0.01 * p_index;
    for (var p_index = 0; p_index < health_ranking_3_list.length; p_index++) health_ranking_3_list[p_index]['health_ranking_point'] += 0.01 * p_index;

    curation_petfood.sort((a, b) => (a['health_ranking_point'] as double).compareTo(b['health_ranking_point'] as double));

    // 하루 권장량
    cal_day_calorie_recommended_amount();
    for (var p_index = 0; p_index < curation_petfood.length; p_index++) {
      curation_petfood[p_index]['day_g'] = cal_day_g_recommended_amount(c_petfood: curation_petfood[p_index]).floor();
      curation_petfood[p_index]['day_price'] = cal_day_price_recommended_amount(c_petfood: curation_petfood[p_index]).floor();
    }
    loading(true);
  }

  void cal_day_calorie_recommended_amount() {
    var per = 70 * pow(double.parse(curation_data['weight']), 0.75);
    var der;
    if (curation_data['pet'] == '0') {
      if (curation_data['month'] < 6) {
        der = per * 3;
      } else if (curation_data['month'] < 13) {
        der = per * 2;
      } else {
        if (curation_data['neutering'] == '0') {
          der = per * 1.6;
        } else {
          der = per * 1.8;
        }
      }
    }
    curation_data['der'] = der.floor();
  }

  double cal_day_g_recommended_amount({c_petfood}) {
    return curation_data['day_g'] = curation_data['der'] / c_petfood['kcal'] * 100;
  }

  double cal_day_price_recommended_amount({c_petfood}) {
    var weight = double.parse(c_petfood['weight'].replaceAll('kg', '')) * 1000;
    var constant = weight / c_petfood['day_g'];
    var day_price = c_petfood['retail_price'] / constant;

    return day_price;
  }

  int health_sub_sorting(a, b, index) {
    int ranking_comp = a['health_ranking_point'].compareTo(b['health_ranking_point']);
    if (ranking_comp == 0) {
      if (curation_data['health'][index] == '뼈/관절') {
        int protein_dm = -a['protein_dm'].compareTo(b['protein_dm']);
        if (protein_dm == 0) {
          return a['fat_dm'].compareTo(b['fat_dm']);
        }
        return protein_dm;
      }
      if (curation_data['health'][index] == '피부/피모') {
        return -a['omega3'].compareTo(b['omega3']);
      }
      if (curation_data['health'][index] == '저알러지') {
        return a['alg'].length.compareTo(b['alg'].length);
        // TODO : 저알러지
      }
      if (curation_data['health'][index] == '항산화') {
        return -a['vita_E'].compareTo(b['vita_E']);
      }
      if (curation_data['health'][index] == '소화기') {
        return a['fat_dm'].compareTo(b['fat_dm']);
      }
      if (curation_data['health'][index] == '다이어트') {
        return a['kcal'].compareTo(b['kcal']);
      }
    }
    return ranking_comp;
  }

  String health_info_text({health_ranking}) {
    for (var h_index = 0; h_index < healthcare[0].length; h_index++) {
      if (curation_data['health'][health_ranking] == healthcare[0][h_index]) {
        return health_info_text_list[h_index];
      }
    }
    return '';
  }

  bool is_ingredient_text_bold({curation, health_care, ingredient}) {
    var cat_health = ['피부/피모', '뼈/관절', '소화기', '다이어트', '저알러지', '항산화'];
    if (!curation) return false;
    if (health_care == '피부/피모') return health_care_bold_check(care_list: skin_care, ingredient: ingredient);
    if (health_care == '뼈/관절') return health_care_bold_check(care_list: bone_care, ingredient: ingredient);
    if (health_care == '소화기') return health_care_bold_check(care_list: digest_care, ingredient: ingredient);
    if (health_care == '다이어트') return health_care_bold_check(care_list: diet_care, ingredient: ingredient);
    if (health_care == '저알러지') return health_care_bold_check(care_list: alg_care, ingredient: ingredient);
    if (health_care == '항산화') return health_care_bold_check(care_list: antioxidant_care, ingredient: ingredient);
    return false;
  }

  bool health_care_bold_check({care_list, ingredient}) {
    for (var c_index = 0; c_index < care_list.length; c_index++) {
      if (ingredient.contains(care_list[c_index])) return true;
    }
    return false;
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

  Future send_kakao() async {
    var options = Options(headers: {'X-secret-Key': secretkey});
    var send_petfood = curation_petfood.where((element) => [0, 1, 2].contains(element['health_ranking'])).toList();
    var message = """[루이스홈 견생사료 찾기 결과 안내]
이름 : ${curation_data['name']}
나이 : ${curation_data['month'] ~/ 12}
중성화 여부 : ${curation_data['sex'].toString() == '0' ? 'O' : 'X'}
알러지 : ${list_to_str(curation_data['algs'])}
건강고민 : ${list_to_str(curation_data['health'])}

${curation_data['name']}의 설문 데이터를 분석하여
루이스홈이 고른 사료들입니다.\n""";

    for (var p_index = 0; p_index < send_petfood.length; p_index++) {
      message += '${send_petfood[p_index]['health_ranking'] + 1}. [${send_petfood[p_index]['brand']}] ${send_petfood[p_index]['short_name']}\n';
    }
    message += """[견생사료 찾기 결과 보기]
버튼을 클릭 하시면 더 자세한
내용을 확인하실 수 있습니다.""";
    print(message.length);
    var data = {
      "senderKey": senderkey,
      "recipientList": [
        {
          "recipientNo": user_info['member_id'].value,
          "content": message,
          "imageSeq": 66915,
          "imageLink": friend_talk_image,
          "buttons": [
            {
              "ordering": 1,
              "type": "WL",
              "name": "버튼 이름",
              "linkPc": "https://louis-home.com/",
              "linkMo": "https://m.louis-home.com/",
            },
          ],
        },
      ],
    };
    final response = await dio.post(nhn_url + 'friendtalk/v2.2/appkeys/${appkey}/messages', data: data, options: options);
    return response.data;
  }

  // Future<dynamic> post_image() async {
  //   var options = Options(headers: {'X-secret-Key': secretkey, "Content-Type": "multipart/form-data"});
  //   final response = await dio.post(nhn_url + 'friendtalk/v2.2/appkeys/${appkey}/images', data: {'image', File('assets/images/kakao_kiosk_image.jpeg')}, options: options);
  // }
}
