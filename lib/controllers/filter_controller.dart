import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/data/category.dart';
import 'package:kiosk_v4/data/petfood.dart';

class FilterController extends GetxController {
  var filtered_petfood_list = petfood_list[user_controller.user_info['pet'].value];
  RxList filtered_petfood_length = [petfood_list[0].length.obs, petfood_list[1].length.obs].obs;
  var selected_filter_list = [[], []];
  RxInt selected_filter_list_length = 0.obs;
  RxList unfold_big_category = List.generate(big_category_list.length, (index) => false.obs).obs;
  RxList show_all_filter_category = List.generate(big_category_list.length, (index) => false.obs).obs;
  RxList selected_filter_category_list = [
    [
      List.generate(filter_category_list[0][0].length, (index) => false.obs),
      List.generate(filter_category_list[0][1].length, (index) => false.obs),
      List.generate(filter_category_list[0][2].length, (index) => false.obs),
    ],
    [
      List.generate(filter_category_list[1][0].length, (index) => false.obs),
      List.generate(filter_category_list[1][1].length, (index) => false.obs),
      List.generate(filter_category_list[1][2].length, (index) => false.obs),
    ]
  ].obs;

  void set_unfold_big_category(index) {
    unfold_big_category[index](!unfold_big_category[index].value);
  }

  void set_show_all_filter_category(index) {
    show_all_filter_category[index](!show_all_filter_category[index].value);
  }

  int category_list_number(category_index) {
    if (filter_category_list[user_controller.user_info['pet'].value][category_index].length > 3) {
      if (show_all_filter_category[category_index].value) {
        return filter_category_list[user_controller.user_info['pet'].value][category_index].length;
      } else {
        return 3;
      }
    }
    return 3;
  }

  void set_selected_filter_category_list(category_index, index) {
    selected_filter_category_list[user_controller.user_info['pet'].value][category_index][index](!selected_filter_category_list[user_controller.user_info['pet'].value][category_index][index].value);
    set_selected_filter_list(filter_category_list[user_controller.user_info['pet'].value][category_index][index]);
    filtering_petfood(petfood_list);
  }

  void filtering_petfood(food_list) {
    filtered_petfood_list = filtering_brand_category(food_list[user_controller.user_info['pet'].value], 0);
    filtered_petfood_list = filtering_multi_select_category(filtered_petfood_list, 1, 'health');
    filtered_petfood_list = filtering_multi_select_category(filtered_petfood_list, 2, 'main_ingredient');
    set_filtered_petfood_length();
  }

  dynamic filtering_brand_category(dynamic current_petfood, category_index) {
    List<Map<String, Object>> temp_list = [];
    int count = selected_filter_category_list[user_controller.user_info['pet'].value][category_index].where((value) => value == true).length;
    if (count != 0) {
      for (var petfood_index = 0; petfood_index < current_petfood.length; petfood_index++) {
        for (var brand_index = 0; brand_index < selected_filter_category_list[user_controller.user_info['pet'].value][category_index].length; brand_index++) {
          if (selected_filter_category_list[user_controller.user_info['pet'].value][category_index][brand_index].value &&
              filter_category_list[user_controller.user_info['pet'].value][category_index][brand_index] == current_petfood[petfood_index]['brand']) {
            temp_list.add(current_petfood[petfood_index]);
          }
        }
      }
      return temp_list;
    }
    return current_petfood;
  }

  dynamic filtering_multi_select_category(current_petfood, category_index, text) {
    List<Map<String, Object>> temp_list = [];
    int count = selected_filter_category_list[user_controller.user_info['pet'].value][category_index].where((value) => value == true).length;
    if (count != 0) {
      for (var petfood_index = 0; petfood_index < current_petfood.length; petfood_index++) {
        var flag = false;
        for (var checkbox_index = 0; checkbox_index < selected_filter_category_list[user_controller.user_info['pet'].value][category_index].length; checkbox_index++) {
          if (selected_filter_category_list[user_controller.user_info['pet'].value][category_index][checkbox_index].value) {
            if (current_petfood[petfood_index][text].indexOf(filter_category_list[user_controller.user_info['pet'].value][category_index][checkbox_index]) != -1) {
              flag = true;
            }
          }
        }
        if (flag) {
          temp_list.add(current_petfood[petfood_index]);
        }
      }
      return temp_list;
    }
    return current_petfood;
  }

  void set_selected_filter_list(category_name) {
    if (selected_filter_list[user_controller.user_info['pet'].value].indexOf(category_name) != -1) {
      selected_filter_list[user_controller.user_info['pet'].value].remove(category_name);
    } else {
      selected_filter_list[user_controller.user_info['pet'].value].add(category_name);
    }
    print(selected_filter_list);
    selected_filter_list_length.value = selected_filter_list[user_controller.user_info['pet'].value].length;
  }

  void set_filtered_petfood_length() {
    filtered_petfood_length[user_controller.user_info['pet'].value](filtered_petfood_list.length);
    filtered_petfood_length[user_controller.user_info['pet'].value]--;
    filtered_petfood_length[user_controller.user_info['pet'].value]++;
  }

  void remove_selected_filter_list(category_name) {
    for (var category = 0; category < filter_category_list[user_controller.user_info['pet'].value].length; category++) {
      var item_index = filter_category_list[user_controller.user_info['pet'].value][category].indexOf(category_name);
      if (item_index != -1) {
        set_selected_filter_category_list(category, item_index);
      }
    }
  }

  void change_pet() {
    filtered_petfood_list = petfood_list[user_controller.user_info['pet'].value];
    user_controller.user_info['pet'].value = user_controller.user_info['pet'].value == 0 ? 1 : 0;
    user_controller.user_info['pet'].value = user_controller.user_info['pet'].value == 0 ? 1 : 0;
    set_filtered_petfood_length();
    selected_filter_list = [[], []];
    selected_filter_list_length = 0.obs;
    unfold_big_category = List.generate(big_category_list.length, (index) => false.obs).obs;
    show_all_filter_category = List.generate(big_category_list.length, (index) => false.obs).obs;
    // for (var index = 0; index < selected_filter_category_list.length; index++) {
    //   for (var category_index = 0; category_index < selected_filter_category_list[index].length; category_index++) {
    //     for (var content_index = 0; content_index < selected_filter_category_list[index][category_index].length; content_index) {
    //       selected_filter_category_list[index][category_index][content_index].value = false;
    //     }
    //   }
    // }
    selected_filter_category_list = [
      [
        List.generate(filter_category_list[0][0].length, (index) => false.obs),
        List.generate(filter_category_list[0][1].length, (index) => false.obs),
        List.generate(filter_category_list[0][2].length, (index) => false.obs),
      ],
      [
        List.generate(filter_category_list[1][0].length, (index) => false.obs),
        List.generate(filter_category_list[1][1].length, (index) => false.obs),
        List.generate(filter_category_list[1][2].length, (index) => false.obs),
      ]
    ].obs;
    refresh();
  }
}
