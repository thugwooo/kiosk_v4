import 'curation.dart';

enum CategoryState { brand, healthcare, main_ingredient }

List popular_category_text = [dog_popular_category_text, cat_popular_category_text];
final dog_popular_category_text = ['퍼피', '어덜트', '시니어', '그레인프리', '단일단백질', '곤충사료', '다이어트'];
final cat_popular_category_text = ['키튼', '어덜트', '시니어', '그레인프리', '단일단백질', '곤충사료', '다이어트'];
final pet_text = ['강아지', '고양이'];
final sort_text = ['판매량 순', '높은가격 순', '낮은가격 순', '큰 알갱이순', '작은 알갱이순'];
final curation_sort_text = ['판매량 순', '높은가격 순', '낮은가격 순', '하루 권장량 대비 높은 가격순', '하루 권장량 대비 낮은 가격순'];

final big_category_list = ['브랜드', 'Life Stage', '반려동물 크기', '건강고려사항', '사료특징', '주원료', '알갱이크기'];
final filter_category_list = [dog_category, cat_category];
final dog_category = [dog_brand_list, dog_life_stage, dog_size, dog_health, dog_petfood_feature, dog_main_ingredient, dog_kibble];
final cat_category = [cat_brand_list, cat_life_stage, cat_size, cat_health, cat_petfood_feature, cat_main_ingredient, cat_kibble];

final dog_brand_list = ['나우', '디바크', '맥아담스', '시그널케어', '아카나', '아투', '몬지', '오리젠', '웰니스', '인스팅트', '지위픽', '토우', '파미나', 'GO!'];
final cat_brand_list = ['나우', '디바크', '맥아담스', '시그널케어', '아카나', '아투', '몬지', '오리젠', '웰니스', '인스팅트', '지위픽', '토우', '파미나', 'GO!'];

final dog_life_stage = ['퍼피', '어덜트', '시니어'];
final cat_life_stage = ['키튼', '어덜트', '시니어'];

final dog_size = ['초소형', '소형', '중형', '대형', '초대형'];
final cat_size = ['무관'];

final dog_petfood_feature = ['고단백', '그레인프리', '글루텐프리', '저알러지', '다이어트', 'NO 옥수수', 'NO 밀', '곤충사료'];
final cat_petfood_feature = ['고단백', '그레인프리', '글루텐프리', '저알러지', '다이어트', 'NO 옥수수', 'NO 밀', '곤충사료'];

final dog_main_ingredient = ['소', '닭', '칠면조', '오리', '양', '멧돼지', '연어', '사슴', '토끼', '생선'];
final cat_main_ingredient = ['소', '닭', '칠면조', '오리', '양', '멧돼지', '연어', '사슴', '토끼', '생선'];

final dog_kibble = ['초소(~8mm)', '소(8~10mm)', '중(10~12mm)', '대(12mm~)'];
final cat_kibble = ['초소(~8mm)', '소(8~10mm)', '중(10~12mm)', '대(12mm~)'];
