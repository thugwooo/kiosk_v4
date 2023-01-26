import 'package:get/get.dart';
import 'package:kiosk_v4/components/rest+api.dart';
import 'package:kiosk_v4/data/petfood.dart';

import '../components/basic_function.dart';
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
    'sex': 0.obs,
    'neutering': 0.obs,
    'bcs': 0.obs,
    'show_alg': 1.obs,
    'alg': [].obs,
    'alg_sub': [].obs,
    'health': [].obs,
    'weight': "".obs,
  }.obs;
  RxBool agreement = false.obs;
  var pet_list = [];
  RxInt pet_length = 0.obs;
  RxInt selected_pet_index = 0.obs;
  RxInt sort_index = 0.obs;
  var curation_data = {}.obs;
  var curation_petfood = [];
  RxInt curation_petfood_length = 0.obs;
  var selected_petfood_list = [];
  RxInt selected_petfood_list_length = 0.obs;

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
      'sex': '0',
      'neutering': '0',
      'bcs': '0',
      'show_alg': '1',
      'alg': [],
      'alg_sub': [],
      'health': [],
      'weight': "",
    });
  }

  void set_user_info_button(index) {
    set_whole_user_info(pet_list[index]);
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
    user_info['health'](str_to_list(data['health']));
    user_info['weight'](data['weight']);
  }

  void get_curation_petfood() {
    post_data(url: 'curation/', data: pet_list[selected_pet_index.value]).then((response) {
      print(response['curation_data']);

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
      set_curation_petfood_length();
      refresh();
    });
    set_curation_petfood_length();
  }

  void set_curation_petfood_length() {
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
}
