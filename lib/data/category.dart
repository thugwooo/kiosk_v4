import 'curation.dart';

enum CategoryState { brand, healthcare, main_ingredient }

List popular_category_text = [dog_popular_category_text, cat_popular_category_text];
final dog_popular_category_text = ['퍼피', '어덜트', '시니어', '그레인프리', '단일단백질', '곤충사료', '다이어트'];
final cat_popular_category_text = ['키튼', '어덜트', '시니어', '그레인프리', '단일단백질', '곤충사료', '다이어트'];
final pet_text = ['강아지', '고양이'];
final sort_text = ['판매량 순', '높은가격 순', '낮은가격 순', '큰 알갱이순', '작은 알갱이순'];
final curation_sort_text = ['판매량 순', '높은가격 순', '낮은가격 순', '하루 권장량 대비 높은 가격순', '하루 권장량 대비 낮은 가격순'];

final big_category_list = ['브랜드', '건강고려사항', '주원료'];
final dog_category = [dog_brand_list, dog_health, dog_main_ingredient];
final cat_category = [cat_brand_list, cat_health, cat_main_ingredient];
final filter_category_list = [dog_category, cat_category];

final dog_life_stage = ['퍼피', '어덜트', '시니어'];
final cat_life_stage = ['키튼', '어덜트', '시니어'];
final dog_brand_list = ['GO!', '나우', '디바크', '맥아담스', '시그널케어', '아카나', ' 오리젠', '워프', '웰니스', '인스팅트', '지위픽', '토우', '파미나', '퓨리나', '허즈'];
final cat_brand_list = ['GO!', '나우', '디바크', '맥아담스', '시그널케어', '아카나', '오리젠', '워프', '웰니스', '인스팅트', '지위픽', '토우', '파미나', '퓨리나', '허즈'];

final dog_main_ingredient = ['소', '닭', '칠면조', '오리', '양', '돼지', '연어', '생선', '계란', '유제품', '옥수수', '곡물', '콩'];
final cat_main_ingredient = ['소', '닭', '칠면조', '오리', '양', '돼지', '연어', '생선', '계란', '유제품', '옥수수', '곡물', '콩'];
