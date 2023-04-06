import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiosk_v4/components/petfood_function.dart';
import 'package:kiosk_v4/components/rest+api.dart';
import 'package:kiosk_v4/components/style.dart';
import 'package:kiosk_v4/controllers/filter_controller.dart';
import 'package:kiosk_v4/controllers/screen_controller.dart';
import 'package:kiosk_v4/controllers/user_controller.dart';
import 'package:kiosk_v4/screens/components/petfood_detail_container.dart';

import '../data/category.dart';
import '../data/screen.dart';

class BasicForm extends StatelessWidget {
  BasicForm({super.key});

  var screen_controller = Get.put(ScreenController());
  var user_controller = Get.put(UserController());
  var filter_controller = Get.put(FilterController());
  var count = 0;

  @override
  Widget build(BuildContext context) {
    // screen_controller.start_timer();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onPanDown: (details) {
        print('onPanDown');
        screen_controller.restart_timer();
      },
      onScaleStart: (details) {
        print('ScaleStart');
        screen_controller.restart_timer();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Obx(
              () => Column(
                children: [
                  _header(),
                  Expanded(
                    child: screen_list[screen_controller.screen_index.value],
                  ),
                  Visibility(visible: MediaQuery.of(context).viewInsets.bottom < 15, child: _custom_bottom_navigation()),
                ],
              ),
            ),
            _speech_bubble(),
            _background(),
            _search_container(),
            _save_container(),
            _kakao_container(),
            Obx(
              () => Visibility(
                visible: screen_controller.petfood_detail_container.value,
                child: PetfoodDetailContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _save_container() {
    return Obx(
      () => Visibility(
        visible: screen_controller.save_container.value,
        child: Positioned(
          left: 20.w,
          top: 47.h,
          child: Container(
              width: 560.w,
              height: 350.h,
              decoration: BoxDecoration(color: background_blue_color_2),
              child: Row(
                children: [_left_form(), SizedBox(width: 20.w), _right_form()],
              )),
        ),
      ),
    );
  }

  Container _right_form() {
    return Container(
      width: 240.w,
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 240.w,
            height: 80.h,
            decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3.w))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h),
                  child: Text(
                    '휴대폰 번호 입력',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('010 - ', style: TextStyle(fontSize: 22.sp)),
                        Text(
                          user_controller.get_phone_number(),
                          style: TextStyle(fontSize: 22.sp, color: user_controller.phone_number.value == '' ? Colors.grey : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Table(
            border: TableBorder.symmetric(
              outside: BorderSide.none,
              inside: BorderSide(width: 0.3.w, color: Colors.grey),
            ),
            children: [
              for (var col_index = 0; col_index < 3; col_index++)
                TableRow(children: [
                  for (var row_index = 1; row_index < 4; row_index++) _single_touchpad(col_index * 3 + row_index),
                ]),
              TableRow(
                children: [
                  MaterialButton(
                    height: 50.h,
                    color: Colors.white,
                    elevation: 0,
                    child: Center(
                        child: Icon(
                      Icons.backspace,
                      size: 22.w,
                    )),
                    onPressed: () {
                      user_controller.back_space_phone_number();
                    },
                  ),
                  _single_touchpad(0),
                  Obx(
                    () => MaterialButton(
                      color: user_controller.phone_number_validator() ? main_color : grey_2,
                      height: 50.h,
                      elevation: 0,
                      child: Center(
                        child: Text('확 인', style: TextStyle(fontSize: 17.sp, color: user_controller.phone_number_validator() ? Colors.white : Colors.grey)),
                      ),
                      onPressed: () {
                        print('asdf');
                        if (user_controller.phone_number.value.length != 8) return;
                        if (!user_controller.agreement.value) {
                          Get.defaultDialog(
                            title: '에러',
                            middleText: '개인정보 활용 동의를 체크하지 않았습니다.',
                            actions: [
                              TextButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Get.back();
                                },
                              )
                            ],
                          );
                        } else {
                          user_controller.set_user_info(text: 'member_id', value: '010' + user_controller.phone_number.value);
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
                                if (value)
                                  {
                                    Get.defaultDialog(
                                      title: '저장',
                                      middleText: '아이 정보를 저장하였습니다.',
                                      actions: [
                                        TextButton(
                                          child: Text(''),
                                          onPressed: () {
                                            // screen_controller.set_kakako_container();
                                          },
                                        )
                                      ],
                                    ),
                                    Future.delayed(Duration(seconds: 1), () {
                                      if (value) {
                                        Get.back();
                                        screen_controller.set_save_container();
                                      }
                                    })
                                  }
                                else
                                  {
                                    Get.defaultDialog(
                                      title: '저장',
                                      middleText: '저장 실패',
                                      actions: [
                                        TextButton(
                                          child: Text('확인'),
                                          onPressed: () {
                                            // screen_controller.set_kakako_container();
                                            Get.back();
                                          },
                                        )
                                      ],
                                    ),
                                  }
                              });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _left_form() {
    return Container(
      padding: EdgeInsets.only(left: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          Text('휴대폰 번호 입력으로', style: TextStyle(fontSize: 19.sp)),
          Text('아이 정보를 저장할 수 있어요', style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 5.h),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 20.w,
                  color: user_controller.agreement.value ? main_color : Colors.grey,
                ),
                SizedBox(width: 10.w),
                Text(
                  '반려동물 정보 저장 및 데이터 활용에 동의합니다.',
                  style: TextStyle(fontSize: 8.sp, color: Color.fromRGBO(128, 128, 128, 1)),
                ),
              ],
            ),
            onTap: () {
              user_controller.set_agreement();
            },
          ),
          SizedBox(height: 30.h),
          Image.asset(
            'assets/sub/curation_dogs.png',
            width: 250.w,
          ),
        ],
      ),
    );
  }

  Widget _single_touchpad(index) {
    return MaterialButton(
      height: 50.h,
      color: Colors.white,
      elevation: 0,
      child: Center(
        child: Text('${index}', style: TextStyle(fontSize: 22.sp)),
      ),
      onPressed: () {
        user_controller.add_number_phone_number(index);
        print(index);
      },
    );
  }

  Widget _kakao_container() {
    return Obx(
      () => Visibility(
        visible: screen_controller.kakao_container.value,
        child: Positioned(
          left: 50.w,
          top: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500.w,
                height: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Column(children: [
                  Text(
                    '카카오톡으로 정보를 받아보시려면 \n아래의 qr코드를 이용해 루이스홈을 친구추가 하신 후 전송 버튼을 누르시면 됩니다.',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(height: 20.h),
                  Image.asset('assets/qr/qrcode_350.png', width: 100.w),
                  SizedBox(height: 20.h),
                  InkWell(
                    child: Container(
                      width: 65.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.7), blurRadius: 1.0.w, spreadRadius: 1.0.w, offset: Offset(1.w, 1.h)),
                        ],
                      ),
                      child: Center(child: Text('카톡보내기', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500))),
                    ),
                    onTap: () {
                      user_controller.send_kakao().then((value) {
                        print(value['message']['sendResults'][0]['resultCode'] == 0);
                        if (value['message']['sendResults'][0]['resultCode'] == -2023) {
                        } else if (value['message']['sendResults'][0]['resultCode'] == 0) {
                          Get.defaultDialog(
                            title: '전송 성공',
                            middleText: '카카오톡 정보 받기 성공',
                            actions: [
                              TextButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Get.back();
                                },
                              )
                            ],
                          );
                        }
                      });
                    },
                  ),
                ]),
              ),
              SizedBox(width: 3.w),
              InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 30.w,
                ),
                onTap: () {
                  screen_controller.set_kakako_container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _search_container() {
    return Obx(
      () => Visibility(
        visible: screen_controller.search_container.value,
        child: Positioned(
          left: 50.w,
          top: 50.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500.w,
                height: 300.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.w,
                          height: 30.h,
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10.w)),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '검색어를 입력해주세요.',
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Icon(
                                  Icons.search,
                                  size: 20.w,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              screen_controller.set_search_text(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Visibility(
                      visible: screen_controller.search_text_bool(),
                      child: Container(
                        width: 400.w,
                        height: 200.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: screen_controller.search_petfood_length.value,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 5.w),
                              child: InkWell(
                                child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3, // soften the shadow
                                        spreadRadius: 3, //extend the shadow
                                        offset: Offset(2.w, 2.h),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      // Image.asset('assets/images/A000001.png'),
                                      Image.asset('assets/images/' + screen_controller.search_petfood[index]['eng_name'] + '.png'),
                                      SizedBox(height: 5.h),
                                      Text(screen_controller.search_petfood[index]['brand'], style: TextStyle(fontSize: 9.sp)),

                                      Text(screen_controller.search_petfood[index]['short_name'], style: TextStyle(fontSize: 9.sp)),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  screen_controller.set_petfood_detail_container(petfood_data: screen_controller.search_petfood[index]);
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 3.w),
              InkWell(
                child: Icon(
                  Icons.cancel,
                  size: 30.w,
                ),
                onTap: () {
                  screen_controller.set_search_container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx _background() {
    return Obx(
      () => Visibility(
        visible: screen_controller.grey_background.value,
        child: Opacity(
          opacity: 0.5,
          child: InkWell(
            child: Container(
              color: Colors.grey,
            ),
            onTap: () {
              if (screen_controller.petfood_detail_container.value) {
                screen_controller.set_petfood_detail_container();
              }
              if (screen_controller.search_container.value) {
                screen_controller.set_search_container();
              }
              if (screen_controller.kakao_container.value) {
                screen_controller.set_kakako_container();
              }
              if (screen_controller.save_container.value) {
                screen_controller.set_save_container();
              }
            },
          ),
        ),
      ),
    );
  }

  Obx _speech_bubble() {
    return Obx(
      () => Visibility(
        visible: screen_controller.show_speech_bubble(),
        child: Stack(
          children: [
            Positioned(
              left: 330.w,
              bottom: 55.h,
              child: Container(
                width: 165.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: mint_color,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(
                    child: Text(
                  '우리 아이에게 딱 맞는 사료를 찾으려면',
                  style: TextStyle(fontSize: 9.sp),
                )),
              ),
            ),
            Positioned(
              left: 348.w,
              bottom: 47.h,
              child: Image.asset(
                'assets/icons/triangle.png',
                width: 13.w,
                color: mint_color,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _custom_bottom_navigation() {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: background_color))),
      child: Row(
        children: [
          _navi_button(index: 0),
          _navi_button(index: 1),
          _navi_button(index: 2),
          _navi_button(index: 3),
          Expanded(
            child: Container(
              height: 63.h,
              decoration: BoxDecoration(color: grey_2),
              child: Row(
                children: [
                  SizedBox(width: 30.w),
                  _pet_button(index: 0),
                  _pet_button(index: 1),
                  SizedBox(width: 20.w),
                  InkWell(
                    child: Image.asset(
                      'assets/icons/magnifying-glass.png',
                      width: 20.w,
                    ),
                    onTap: () {
                      screen_controller.set_search_container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navi_button({index}) {
    return Obx(
      () => InkWell(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: screen_controller.is_selected_bottom_navi_index(index) ? main_color : grey_2,
              ),
              width: 96.w,
              height: 63.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    navi_icons[index],
                    width: 18.w,
                    color: screen_controller.is_selected_bottom_navi_index(index) ? Colors.white : Colors.black,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    navi_Text[index],
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: screen_controller.is_selected_bottom_navi_index(index) ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: [0, 1].contains(index),
              child: Positioned(
                left: 30.w,
                child: Visibility(
                  visible: screen_controller.is_selected_bottom_navi_index(index),
                  child: Image.asset(
                    'assets/icons/triangle.png',
                    width: 13.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          if (index == 0) {
            sort_location();
          }
          screen_controller.set_navi_index(index);
        },
      ),
    );
  }

  Widget _header() {
    return Obx(
      () => Visibility(
        visible: screen_controller.screen_index.value != ScreenState.curation_recommend_petfood_screen.index,
        child: Container(
          color: screen_controller.screen_index.value != ScreenState.curation_exist_user_screen.index ? Colors.white : background_blue_color_2,
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Row(
              children: [
                SizedBox(width: 20.w),
                InkWell(
                  child: Image.asset(
                    'assets/icons/vertical_logo.png',
                    width: 126.w,
                  ),
                  onTap: () {
                    // screen_controller.screen_index(ScreenState.test_screen.index);
                  },
                ),
                SizedBox(width: 15.w),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pet_button({index}) {
    return Obx(
      () => InkWell(
        child: Container(
          width: 62.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: user_controller.is_selected_user_info(text: 'pet', index: index) ? main_color : Colors.white,
            border: Border.all(width: 0.25.w, color: Colors.grey),
            borderRadius:
                index == 0 ? BorderRadius.only(topLeft: Radius.circular(5.w), bottomLeft: Radius.circular(5.w)) : BorderRadius.only(topRight: Radius.circular(5.w), bottomRight: Radius.circular(5.w)),
          ),
          child: Center(
            child: Text(
              '${pet_text[index]}',
              style: TextStyle(fontSize: 11.sp, color: user_controller.is_selected_user_info(text: 'pet', index: index) ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        onTap: () {
          user_controller.set_user_info(text: 'pet', value: index);
          user_controller.set_petfood_list_length();
          filter_controller.change_pet();
        },
      ),
    );
  }
}
