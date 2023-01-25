import 'package:flutter/material.dart';

import '../screens/curation/curation_exist_user_screen.dart';
import '../screens/curation/curation_input_screen.dart';
import '../screens/curation/curation_main_screen.dart';
import '../screens/curation/curation_new_user_screen.dart';
import '../screens/curation/curation_pet_screen.dart';
import '../screens/curation/curation_recommend_petfood_screen.dart';
import '../screens/curation/curation_record_petfood_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../screens/petfood_filter_screen/petfood_filter_screen.dart';
import '../screens/popular_categories_screen/popular_category_display_screen.dart';
import '../screens/popular_categories_screen/popular_category_screen.dart';

final speech_bubble = [ScreenState.main_screen.index, ScreenState.popular_category_screen.index];

enum ScreenState {
  main_screen,
  popular_category_screen,
  petfood_filter_screen,
  curation_main_screen,
  popular_display_screen,
  curation_new_user_screen,
  curation_exist_user_screen,
  curation_input_screen,
  curation_pet_screen,
  curation_record_petfood_screen,
  curation_recommend_petfood_screen,
}

List navi_icons = ['assets/icons/home.png', 'assets/icons/star.png', 'assets/icons/filter.png', 'assets/icons/cat.png'];
List navi_Text = ['메인 화면', '인기 카테고리', '사료 필터', '1:1 사료 추천'];
List<Widget> screen_list = [
  MainScreen(),
  PopularCategoryScreen(),
  PetfoodFilterScreen(),
  CurationMainScreen(),
  PopularCategoryDisplayScreen(),
  CurationNewUserScreen(),
  CurationExistUserScreen(),
  CurationInputScreen(),
  CurationPetScreen(),
  CurationRecordPetfoodScreen(),
  CurationRecommendPetfoodScreen(),
];
