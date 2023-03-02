import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';

import '../../components/rest+api.dart';
import '../../components/style.dart';
import '../../data/curation.dart';
import '../../data/screen.dart';

class CurationInputScreen extends StatelessWidget {
  CurationInputScreen({Key? key}) : super(key: key);
  var user_controller = Get.put(UserController());
  var screen_controller = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        width: 600.w,
        color: Color.fromRGBO(248, 248, 248, 1),
        child: SingleChildScrollView(
          controller: user_controller.scroll_controller.value,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Text('내 반려 동물의 기본정보를 알려주세요.', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h),
              _custom_textfield(title: '이름', text: 'name', is_number: false),
              SizedBox(height: 15.h),
              _breed_dropdown(),
              SizedBox(height: 15.h),
              _birth_dropdown(),
              SizedBox(height: 15.h),
              _sex_form(),
              SizedBox(height: 15.h),
              _neutering_form(),
              SizedBox(height: 15.h),
              _custom_textfield(title: "몸무게", text: "weight"),
              SizedBox(height: 15.h),
              // _bcs_form(),
              // SizedBox(height: 15.h),
              _show_alg_form(),
              SizedBox(height: 15.h),
              _alg_form(),
              _healthcare_form(),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _screen_move_button(text: '저장하기', fill: true),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _screen_move_button({text, fill}) {
    return InkWell(
      child: Container(
        width: small_container_width,
        height: curation_box_height,
        decoration: fill
            ? BoxDecoration(color: grey_color, borderRadius: BorderRadius.circular(5.w))
            : BoxDecoration(
                border: Border.all(color: main_color, width: 0.5.w),
                borderRadius: BorderRadius.circular(5.w),
              ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 10.sp, color: fill ? Colors.black : main_color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () {
        var dialog_data = user_controller.input_check_form();
        if (dialog_data['dialog_text'] == '') {
          post_data(url: 'pet-save/', data: {
            'member_id': user_controller.user_info['member_id'].value,
            'pet': user_controller.user_info['pet'].value,
            'name': user_controller.user_info['name'].value,
            'breed': user_controller.user_info['breed'].value,
            'birth_year': user_controller.user_info['birth_year'].value,
            'birth_month': user_controller.user_info['birth_month'].value,
            'birth_day': user_controller.user_info['birth_day'].value,
            'sex': user_controller.user_info['sex'].value,
            'neutering': user_controller.user_info['neutering'].value,
            'weight': user_controller.user_info['weight'].value,
            'bcs': user_controller.user_info['bcs'].value,
            'alg': user_controller.user_info['alg'].value,
            'alg_sub': user_controller.user_info['alg_sub'].value,
            'health': user_controller.user_info['health'].value,
          }).then((value) => {
                screen_controller.set_screen_index(ScreenState.curation_pet_screen.index),
              });
        } else {
          Get.dialog(
            AlertDialog(
              title: Text('${dialog_data["dialog_text"]}'),
              actions: [
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Get.back();
                    print(dialog_data['scroll']);
                    user_controller.scroll_up(dialog_data['scroll']);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _healthcare_form() {
    return Column(
      children: [
        _row_form(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _custom_title_form(title: '건강관리'),
              _healthcare_ranking(index: 0),
              SizedBox(
                width: 5.w,
              ),
              _healthcare_ranking(index: 1),
              SizedBox(
                width: 5.w,
              ),
              _healthcare_ranking(index: 2),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        _row_form(
            child: Row(
          children: [
            _custom_title_form(title: ''),
            Container(
              width: curation_container_width,
              child: Obx(
                () => Wrap(
                  spacing: 5.w,
                  runSpacing: 5.h,
                  children: [
                    for (var health_index = 0; health_index < healthcare[user_controller.user_info['pet'].value].length; health_index++)
                      // 58.w,20.h
                      InkWell(
                        child: Container(
                          width: 58.w,
                          height: 20.h,
                          decoration: user_controller.is_selected_list_button(text: 'health', value: healthcare[user_controller.user_info['pet'].value][health_index])
                              ? BoxDecoration(
                                  color: health_background_color[user_controller.user_info['health'].indexOf(healthcare[user_controller.user_info['pet'].value][health_index])],
                                  borderRadius: BorderRadius.circular(5.w))
                              : white_box_deco,
                          child: Center(
                            child: Text(healthcare[user_controller.user_info['pet'].value][health_index]),
                          ),
                        ),
                        onTap: () {
                          user_controller.set_health_ranking(value: healthcare[user_controller.user_info['pet'].value][health_index]);
                        },
                      )
                  ],
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }

  Widget _healthcare_ranking({index}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: small_container_width,
          height: curation_box_height,
          decoration: BoxDecoration(border: Border.all(color: health_border_color[index]), borderRadius: BorderRadius.circular(5.w), color: Colors.white),
          child: Center(child: Text(user_controller.user_info['health'][index] == '' ? '${index + 1}순위' : user_controller.user_info['health'][index])),
        ),
        onTap: () {
          user_controller.remove_health_ranking(index: index);
        },
      ),
    );
  }

  Obx _alg_form() {
    return Obx(
      () => Visibility(
        visible: user_controller.user_info['show_alg'].value == 0,
        child: _row_form(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _custom_title_form(title: '알러지'),
                  Container(
                    width: curation_container_width,
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 5.w,
                          runSpacing: 5.h,
                          children: [
                            for (var alg_index = 0; alg_index < alg[user_controller.user_info['pet'].value].length; alg_index++)
                              _multi_select_button(index: alg_index, text: 'alg', list: alg, width: 37.w, height: 20.h),
                          ],
                        ),
                        _alg_sub_form(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alg_sub_form() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 37.w,
              height: 20.h,
              child: Center(child: Text('기타')),
            ),
            SizedBox(width: 5.w),
            Container(
              width: 163.w,
              height: curation_box_height,
              padding: EdgeInsets.only(left: 10.w),
              decoration: white_box_deco,
              child: DropdownSearch(
                dropdownDecoratorProps: DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(border: InputBorder.none)),
                dropdownBuilder: ((context, selectedItem) {
                  return Text(selectedItem ?? "", style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500));
                }),
                popupProps: PopupProps.menu(
                  disabledItemFn: (String s) => s.startsWith('I'),
                  showSearchBox: true,
                ),
                items: alg_sub_list,
                selectedItem: "",
                onChanged: (value) {
                  user_controller.set_user_list_info(text: 'alg_sub', value: value);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Obx(
          () => Container(
            width: curation_container_width,
            child: Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: [
                for (var sub_index = 0; sub_index < user_controller.user_info['alg_sub'].length; sub_index++) _alg_sub_container(index: sub_index),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _alg_sub_container({index}) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        height: 15.h,
        decoration: BoxDecoration(
          color: Color.fromRGBO(205, 221, 255, 1),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user_controller.user_info['alg_sub'][index]),
            SizedBox(width: 3.w),
            Icon(
              Icons.cancel,
              color: main_color,
            ),
          ],
        ),
      ),
      onTap: () {
        user_controller.set_user_list_info(text: 'alg_sub', value: user_controller.user_info['alg_sub'][index]);
      },
    );
  }

  Obx _multi_select_button({index, text, list, width, height}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: width,
          height: height,
          decoration: user_controller.is_selected_list_button(text: text, value: list[user_controller.user_info['pet'].value][index]) ? louis_box_deco : white_box_deco,
          child: Center(
            child: Text(
              list[user_controller.user_info['pet'].value][index],
              style: user_controller.is_selected_list_button(
                text: text,
                value: list[user_controller.user_info['pet'].value][index],
              )
                  ? curation_selected_contents_style
                  : curation_contents_style,
            ),
          ),
        ),
        onTap: () {
          user_controller.set_user_list_info(text: text, value: list[user_controller.user_info['pet'].value][index]);
        },
      ),
    );
  }

  Widget _show_alg_form() {
    return _row_form(
      child: Row(children: [
        _custom_title_form(title: '알러지 여부'),
        _select_button(index: 0, text: 'show_alg', list: y_n),
        SizedBox(width: 5.w),
        _select_button(index: 1, text: 'show_alg', list: y_n),
      ]),
    );
  }

  Widget _bcs_form() {
    return _row_form(
      child: Row(
        children: [
          _custom_title_form(title: '체형'),
          _select_button(index: 0, text: 'bcs', list: bcs),
          SizedBox(width: 5.w),
          _select_button(index: 1, text: 'bcs', list: bcs),
          SizedBox(width: 5.w),
          _select_button(index: 2, text: 'bcs', list: bcs),
        ],
      ),
    );
  }

  Widget _neutering_form() {
    return _row_form(
      child: Row(
        children: [
          _custom_title_form(title: '중성화 여부'),
          _select_button(index: 0, text: 'neutering', list: y_n),
          SizedBox(width: 5.w),
          _select_button(index: 1, text: 'neutering', list: y_n),
        ],
      ),
    );
  }

  Widget _sex_form() {
    return _row_form(
      child: Row(
        children: [
          _custom_title_form(title: '성별'),
          _select_button(index: 0, text: 'sex', list: sex),
          SizedBox(width: 5.w),
          _select_button(index: 1, text: 'sex', list: sex),
        ],
      ),
    );
  }

  Widget _select_button({index, text, list}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: small_container_width,
          height: curation_box_height,
          decoration: user_controller.is_selected_user_info(text: text, index: index) ? louis_box_deco : white_box_deco,
          child: Center(
            child: Text(
              list[index],
              style: user_controller.is_selected_user_info(text: text, index: index) ? curation_selected_contents_style : curation_contents_style,
            ),
          ),
        ),
        onTap: () {
          user_controller.set_user_info(text: text, value: index);
        },
      ),
    );
  }

  Widget _birth_dropdown() {
    return _row_form(
      child: Row(
        children: [
          _custom_title_form(title: '생년월일'),
          _custom_dropdown_search(width: small_container_width, text: 'birth_year', list: birth_year),
          SizedBox(width: 5.w),
          _custom_dropdown_search(width: small_container_width, text: 'birth_month', list: birth_month),
          SizedBox(width: 5.w),
          _custom_dropdown_search(width: small_container_width, text: 'birth_day', list: birth_day),
        ],
      ),
    );
  }

  Widget _breed_dropdown() {
    return _row_form(
      child: Obx(
        () => Row(
          children: [
            _custom_title_form(title: pet_breed_text[user_controller.user_info['pet'].value]),
            _custom_dropdown_search(width: curation_container_width, text: 'breed', list: breed[user_controller.user_info['pet'].value], show_search_box: true),
          ],
        ),
      ),
    );
  }

  Widget _custom_dropdown_search({width, text, list, show_search_box = false}) {
    return Container(
      width: width,
      height: curation_box_height,
      padding: EdgeInsets.only(left: 10.w),
      decoration: white_box_deco,
      child: DropdownSearch(
        dropdownDecoratorProps: DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(border: InputBorder.none)),
        dropdownBuilder: ((context, selectedItem) {
          return Text(selectedItem ?? "", style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500));
        }),
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          disabledItemFn: (String s) => s.startsWith('I'),
          showSearchBox: show_search_box,
        ),
        items: list,
        selectedItem: user_controller.user_info[text].toString(),
        onChanged: (value) {
          user_controller.set_user_info(text: text, value: value);
        },
      ),
    );
  }

  Widget _custom_textfield({title, text, is_number = true}) {
    return _row_form(
      child: Row(
        children: [
          _custom_title_form(title: title),
          Container(
            width: text != "weight" ? curation_container_width : small_container_width,
            height: curation_box_height,
            padding: EdgeInsets.only(left: 10.w),
            decoration: white_box_deco,
            child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none),
              initialValue: user_controller.user_info[text].value,
              keyboardType: is_number ? TextInputType.number : TextInputType.text,
              onChanged: (value) {
                user_controller.set_user_info(text: text, value: value);
              },
            ),
          ),
          Visibility(
            visible: text == 'weight',
            child: Row(
              children: [
                SizedBox(width: 10.w),
                Text('kg', style: TextStyle(fontSize: 10.w)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _custom_title_form({title}) {
    return Container(
      padding: EdgeInsets.only(top: 4.h),
      width: curation_title_width,
      height: curation_box_height,
      child: Text(
        title,
        style: curation_subtitle_style,
      ),
    );
  }

  Widget _row_form({child}) {
    return Container(width: curation_row_width, child: child);
  }
}
