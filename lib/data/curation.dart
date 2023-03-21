final sort_petfood_text = ['높은 가격순', '낮은 가격순', '큰 알갱이순', '작은 알갱이순'];
final sort_text = ['dsc_price', 'asc_price', 'dsc_kibble', 'asc_kibble'];
final user_type = ['신규 회원', '기존 회원'];
var alg = [dog_alg, cat_alg];
var pet_breed_text = ['견종', '묘종'];
var sex = ['수컷', '암컷'];
var y_n = ['YES', 'NO'];
var bcs = ['말랐어요', '적당해요', '통통해요'];
var healthcare = [dog_health, cat_health];
var breed = [dog_breed, cat_breed];
var birth_year = List.generate(24, (index) => (index + 2000).toString());
var birth_month = List.generate(12, (index) => (index + 1).toString());
var birth_day = List.generate(31, (index) => (index + 1).toString());
var dog_alg = ['소', '닭', '칠면조', '오리', '양', '돼지', '연어', '생선', '계란', '유제품', '옥수수', '곡물', '콩'];
var cat_alg = ['소', '닭', '칠면조', '오리', '양', '돼지', '연어', '생선', '계란', '유제품', '옥수수', '곡물', '콩'];
var alg_sub_list = [
  'β - 락 토 글 로 불 린',
  '가자미',
  '가재',
  '감',
  '감자',
  '갑각류',
  '강낭콩',
  '강황',
  '검정콩',
  '게',
  '결명자',
  '계란노른자',
  '계란흰자',
  '계피',
  '고구마',
  '고등어',
  '과일',
  '광어',
  '구기자',
  '귀리',
  '귤',
  '그린빈',
  '그린티',
  '근대',
  '글루텐',
  '꿀',
  '난각',
  '녹차',
  '농어',
  '당근',
  '대구',
  '대두',
  '동충하초',
  '들깨',
  '딸기',
  '땅콩',
  '라벤더',
  '라임',
  '라즈베리',
  '랍스터',
  '레몬',
  '렌틸콩(렌즈콩)',
  '로즈마리',
  '로즈힙',
  '마늘',
  '마시멜로',
  '망고',
  '맥주 효모',
  '멀베리',
  '메밀',
  '메추리',
  '멜론',
  '멧돼지',
  '멸치',
  '무',
  '미강',
  '밀',
  '바나나',
  '바질',
  '밤',
  '배',
  '배추',
  '버터',
  '버터넛스쿼시',
  '번데기',
  '베이킹파우더',
  '병아리콩',
  '보리',
  '보스웰리아',
  '복숭아',
  '볼락',
  '북어',
  '브로콜리',
  '블루베리',
  '비트',
  '비트펄프(사탕무박)',
  '빌베리',
  '빵 효모',
  '사과',
  '사스카툰베리',
  '사슴',
  '사탕무',
  '산양유',
  '상어',
  '새송이',
  '새우',
  '샐러리',
  '생강',
  '소금',
  '송어',
  '수박',
  '순무',
  '시금치',
  '식용곤충',
  '쌀',
  '아마',
  '알로에베라',
  '알팔파',
  '양상추',
  '어패류',
  '연근',
  '염소',
  '오렌지',
  '오이',
  '완두콩',
  '요거트',
  '우무',
  '우엉',
  '우유',
  '유카',
  '육류',
  '이스트',
  '이집트콩',
  '자두',
  '잠두',
  '정어리',
  '조',
  '조개',
  '주키니호박',
  '차전자피',
  '참치',
  '찹쌀',
  '채소',
  '청경채',
  '청어',
  '체다치즈',
  '초록입홍합',
  '초유',
  '치아씨앗',
  '치즈',
  '치커리',
  '카모마일',
  '카사바',
  '카우베리',
  '카제인',
  '케일',
  '켈프',
  '코코넛',
  '콜리플라워',
  '크랜베리',
  '클로렐라',
  '키위(참다래)',
  '타조',
  '타피오카',
  '토끼',
  '토마토',
  '파스닙',
  '파슬리',
  '파인애플',
  '파프리카',
  '페퍼민트',
  '펜넬',
  '표고버섯',
  '플라보노이드',
  '한천',
  '해바라기',
  '해조류',
  '현미',
  '호랑이콩',
  '호밀',
  '호박',
  '호손베리',
  '호키',
  '홍합',
  '황기',
  '황태',
  '효모',
  '흰살생선'
];
var dog_health = ['피부/피모', '뼈/관절', '소화기', '다이어트', '저알러지', '항산화'];
var cat_health = ['피부/피모', '뼈/관절', '소화기', '다이어트', '저알러지', '항산화'];
var health_info_text_list = [
  '필수 지방산인 오메가-3가 포함되어있어 피부/피모에 도움을 줍니다.',
  '뼈/관절 건강에 도움이 되는 단백질이 풍부하게 들어가 있습니다.',
  '지방이 적고 적절한 섬유질과 유산균이 포함되어 소화기에 좋은 사료입니다.',
  '지방 함량과 칼로리가 낮은 제품입니다.',
  '한 가지 단백질과 최소한의 재료로 만들어진 저알러지 사료입니다.',
  '',
];
var skin_care = ['계란', '청어', '청어유', '청어오일', '연어유', '연어오일', '가자미', '고등어', '당근'];
var bone_care = ['계란 흰자', '상어연골', '강황', '글루코사민', '콘드로이틴', 'MSM', '식이유황', '초록입홍합', '뉴질랜드 녹색홍합', '로즈힙', '아스코르브산', '비타민C'];
var digest_care = ['초유', '이눌린', '락토 바실러스 플란타륨', '엔테로코커스 패시움', '엔테로코커스 패슘', '락토바실러스 카제이', '락토바실러스 애시도필러스'];
var diet_care = ['가자미', 'L-카르니틴', '코코넛', '녹차추출물', '그린티추출물'];
var alg_care = [];
var antioxidant_care = ['비타민E', '베타카로틴', '아스코르브산', '비타민C', '녹차추출물', '그린티추출물'];
var dog_breed = [
  '소형견 믹스',
  '중형견 믹스',
  '대형견 믹스',
  '가스콘 세인톤죠이스',
  '고든 세터',
  '골든 레트리버',
  '그랜드 그리폰 방뎅',
  '그랜드 바셋 그리폰 방뎅',
  '그레이 하운드',
  '그레이트 가스코니 블루',
  '그레이트 데인',
  '그레이트 스위스 마운틴 독',
  '그레이트 앵글로-프렌치 트라이컬러 하운드',
  '그레이트 앵글로-프렌치 화이트 앤드 블랙 하운드',
  '그레이트 앵글로-프렌치 화이트 앤드 오렌지 하운드',
  '그리폰 브뤼셀',
  '그리퐁 니베르네',
  '그릭 헤어하운드',
  '그린란드견',
  '기슈',
  '나폴리탄 마스티프',
  '노르보텐스피츠',
  '노르웨이 룬트훈트',
  '노르웨이안 부훈트',
  '노르웨이언 엘크 하운드',
  '노리치 테리어',
  '노바 스코셔 덕 톨링 리트리버',
  '노퍽 테리어',
  '뉴펀들랜드',
  '닥스훈트 (미니어처)',
  '닥스훈트 (표준)',
  '달마시안',
  '대니시 스웨디시 팜독',
  '댄디 딘몬트 테리어',
  '더치 샤펜도스',
  '더치 셰퍼드 독',
  '더치 스모우스혼트',
  '도고 아르헨티노',
  '도그 드 보르도',
  '도버맨 핀셔',
  '도베르만',
  '도이치 스티첼할',
  '드레버',
  '디어하운드',
  '라브라도 리트리버',
  '라사압소',
  '라지 문스터랜더',
  '라포니안 허더',
  '란트저',
  '래브라도 레트리버',
  '러시안 블랙 테리어',
  '러시안 토이',
  '러시안-유러피안 라이카',
  '러프 콜리',
  '레온베르거',
  '레이크랜드 테리어',
  '로디지안 리지백',
  '로마그나 워터 독',
  '로첸',
  '로트바일러',
  '루마니안 미오리틱 셰퍼드',
  '루마니안 카르파티안 셰퍼드',
  '마스티프',
  '마요르카 마스티프',
  '마요르카 셰퍼드',
  '말티즈',
  '말티푸',
  '맨체스터 테리어 (표준)',
  '멕시칸 헤어리스 독',
  '몬터니그런 마운틴 하운드',
  '무디',
  '미니어처 핀셔',
  '바바리안 마운틴 센트 하운드',
  '바베트',
  '바센지',
  '바셋 블뢰 드 가스코뉴',
  '바셋 아르테지앙 노르망',
  '바셋 포브 드 브르타뉴',
  '바셋 하운드',
  '바셋하운드',
  '바이마리너',
  '버니즈 마운틴 도그',
  '벌고 포인팅 독',
  '베들링턴 테리어',
  '베르가마스코 셰퍼드 독',
  '벨지안 그리펀',
  '벨지안 셰퍼드',
  '보더 콜리',
  '보더 테리어',
  '보르조이',
  '보스니안 하운드',
  '보스쉽독',
  '보스턴 테리어',
  '보헤미안 와이어 헤어드 포인팅 그리폰',
  '복서',
  '볼로네즈',
  '부비에 데 플랑드르',
  '부비에 드 아르덴느',
  '불 마스티프',
  '불 테리어',
  '불독',
  '불독',
  '불테리어',
  '브라질리언 테리어',
  '브란틀브라케',
  '브로홀머',
  '브뤼셀 그리펀',
  '브리아드',
  '브리케 그리폰 방댕',
  '브리타니 스패니얼',
  '브리티시 스패니얼',
  '블랙 앤 탄 쿤하운드',
  '블러드 하운드',
  '블루 피카르디 스패니얼',
  '비글',
  '비글 해리어',
  '비숑 프리제',
  '비어디드 콜리',
  '비즐라- 헝가리안 숏 헤어드 포인터',
  '빌리',
  '뿌아뚜방',
  '쁘띠 바셋 그리펀 벤딘',
  '쁘띠 브라방송',
  '사를로스볼프혼트',
  '사모예드',
  '사모예드',
  '살루키',
  '샤페이',
  '서식스 스패니얼',
  '석세스 스패니얼',
  '세르비안 트라이컬러 하운드',
  '세르비안 하운드',
  '세인트 버나드',
  '세인트 저먼 포인터',
  '셔틀랜드 쉽독',
  '슈나우저',
  '슈나우저 (대형)',
  '슈나우저 (미니어처)',
  '슈나우저 (표준)',
  '스몰 블루 가스코니',
  '스몰란스퇴바레',
  '스무드 폭스 테리어',
  '스무스 콜리',
  '스웨디시 라프훈트',
  '스웨디시 발훈트',
  '스위스 하운드',
  '스카이 테리어',
  '스코티시 테리어',
  '스키퍼키',
  '스타이리안 콜스 헤어드 하운드',
  '스타포드셔 불 테리어',
  '스테비훈',
  '스패니쉬 그레이하운드',
  '스패니시 워터 독',
  '스패니시 하운드',
  '스페니쉬 마스티프',
  '스피노네 이탈리아노',
  '슬로바키안 쿠바크',
  '슬로바키안 하운드',
  '슬루기',
  '시르네코 델레트나',
  '시바 이누',
  '시바 이누',
  '시베리안 허스키',
  '시추',
  '시츄',
  '실레르스퇴바레',
  '실리엄 테리어',
  '실키 테리어',
  '아르토이스 하운드',
  '아리에쥬아',
  '아메리칸 스태퍼드셔 테리어',
  '아메리칸 아키타',
  '아메리칸 워터 스패니얼',
  '아메리칸 코커 스패니얼',
  '아메리칸 폭스하운드',
  '아이리쉬 소프트코티드 휘튼 테리어',
  '아이리쉬 워터 스파니엘',
  '아이리시 글렌 오브 이말 테리어',
  '아이리시 레드 세터',
  '아이리시 레드 앤드 화이트 세터',
  '아이리시 세터',
  '아이리시 울프 하운드',
  '아이리시 워터 스패니얼',
  '아이리시 테리어',
  '아이리시 테리어',
  '아이슬랜드 쉽독',
  '아펜젤러 세넨훈드',
  '아펜핀셔',
  '아펜핀셔',
  '아프간 하운드',
  '아프간 하운드',
  '알래스칸 맬러뮤트',
  '알렌테조 라페이로',
  '알파인 닥스브라크',
  '앵글로 프렌치 하운드',
  '에리에지 포인터',
  '에스키모',
  '에스트렐라 마운틴 독',
  '에어데일 테리어',
  '에이디',
  '엔틀버쳐 케틀 독',
  '오스트레일리안 셰퍼드',
  '오스트레일리안 스텀피테일 캐틀 독',
  '오스트레일리안 켈피',
  '오스트레일리언 실키 테리어',
  '오스트레일리언 테리어',
  '오스트리안 핀셔',
  '오터 하운드',
  '올드 대니시 포인팅 독',
  '올드 잉글리시 시프도그',
  '와이마라너',
  '와이어 폭스 테리어',
  '와이어헤드 포인팅 그리폰',
  '와이어헤드 폭스 테리어',
  '요크셔 테리어',
  '우루과이안 시마론',
  '웨스트 시베리언 라이카',
  '웨스트 하이랜드 화이트 테리어',
  '웨스트팔리안 닥스브라케',
  '웰시 스프링스 스페니얼',
  '웰시 테리어',
  '웰시코기',
  '웰시코기 (카디건)',
  '웰시코기 (펨브룩)',
  '웰치 스프링거 스패니얼',
  '유라시안',
  '이비전 포덴코',
  '이스트 시베리안 라이카',
  '이스트리안 숏 헤어드 하운드',
  '이스트리안 와이드 헤어드 하운드',
  '이탈리아 포인팅 독',
  '이탈리안 그레이 하운드',
  '이탈리안 숏 헤어드 세구죠',
  '이탈리안 콜스 헤어드 하운드',
  '잉글리시 세터',
  '잉글리시 세터',
  '잉글리시 스프링거 스패니얼',
  '잉글리시 코커 스패니얼',
  '잉글리시 코커 스패니얼',
  '잉글리시 토이 스패니얼',
  '잉글리시 토이 테리어',
  '잉글리시 포인터',
  '잉글리시 폭스하운드',
  '자이언트 슈나우져',
  '잠트훈트',
  '잭 러셀 테리어',
  '저먼 롱 헤어드 포인팅 독',
  '저먼 셰퍼드',
  '저먼 쇼트 헤어드 포인팅 독',
  '저먼 스패니얼',
  '저먼 와이어헤어드 포인팅 독',
  '저먼 핀셔',
  '저먼 하운드',
  '제패니즈 스피츠',
  '제패니즈 친',
  '제패니즈 테리어',
  '진돗개',
  '차우차우',
  '차이니스 크레스티드',
  '체서피크 베어 리트리버',
  '체스키 테리어',
  '체코슬로바키아 늑대개',
  '치와와',
  '카네코르소',
  '카르스트 셰퍼드 독',
  '카발리에 킹 찰스 스패니얼',
  '카스트로 라보레이로 독',
  '카이',
  '카탈란 쉽독',
  '캉갈 셰퍼드',
  '커릴리언 베어 독',
  '컬리 코티드 리트리버',
  '케리 블루 테리어',
  '케언 테리어',
  '케이넌 독',
  '케이스혼드',
  '코몬돌',
  '코통 드 튈레아르',
  '콘티넨탈 토이 스파니엘',
  '콜리',
  '쿠바츠',
  '쿠이커혼제',
  '크로아티안 셰퍼드 독',
  '크롬폴란데',
  '클라인 문스터렌더',
  '클럼버 스패니얼',
  '클럼버 스패니얼',
  '킹 찰스 스패니얼',
  '타이 리지백',
  '타이완 독',
  '타트라 마운틴 쉽독',
  '토이푸들',
  '티롤리안 하운드',
  '티베탄 마스티프',
  '티베탄 스패니얼',
  '티베탄 테리어',
  '파라오 하운드',
  '파릴리온',
  '파슨 러셀 테리어',
  '퍼그',
  '페루비안 잉카 오키드',
  '페커니즈',
  '페키니즈',
  '펨브록 웰시코기',
  '포뎅코 카나리오',
  '포르셀엔',
  '포르투기즈 쉽독',
  '포르투기즈 워터 독',
  '포르투기즈 포인팅 독',
  '포메라니안',
  '포사바츠 하운드',
  '포인터',
  '폭스 테리어',
  '폭스 테리어 스무스',
  '폰 브리태니 그리폰',
  '폴리쉬 로랜드 쉽독',
  '폴리쉬 헌팅 독',
  '퐁토드메르 스패니얼',
  '푸델포인터',
  '푸들 (미니어처)',
  '푸들 (표준)',
  '푸미',
  '풀리',
  '프레사 카나리오',
  '프렌치 불독',
  '프렌치 불독',
  '프렌치 스패니얼',
  '프렌치 트라이컬러 하운드',
  '프렌치 포인팅 독',
  '프렌치 화이트 앤드 블랙 하운드',
  '프렌치 화이트 앤드 오렌지 하운드',
  '프리지안 워터 독',
  '플랫 코티드 리트리버',
  '피니시 스피츠',
  '피니시 하운드',
  '피레니안 마스티프',
  '피레니안 마운틴',
  '피레니안 쉽독',
  '피카디 스패니얼',
  '피카르디 셰퍼드',
  '필드 스패니얼',
  '하노베리안 센트 하운드',
  '하이겐 하운드',
  '할덴 하운드',
  '해리어',
  '해밀턴스퇴바레',
  '허배너스',
  '헝가리안 그레이하운드(마자르 아가)',
  '헝가리안 와이어-헤어드 포인터(비즐라)',
  '호바와트',
  '화이트 스위스 셰퍼드',
  '휘핏'
];
var cat_breed = [
  '단모종 믹스',
  '장모종 믹스',
  '네바 마스커레이드',
  '노르웨이 숲',
  '데본렉스',
  '돈스코이',
  '라가머핀',
  '라팜',
  '랙돌',
  '러시안블루',
  '맹크스',
  '먼치킨',
  '메인쿤',
  '발리니즈',
  '버마고양이',
  '버만',
  '버밀라',
  '벵갈',
  '봄베이',
  '브리티쉬 롱헤어',
  '브리티시 숏헤어',
  '샤르트뢰',
  '샴',
  '세이셸루아',
  '셀커크 렉스',
  '소말리',
  '소코케',
  '스노우슈',
  '스코티시 스트레이트',
  '스코티시 폴드',
  '스핑크스',
  '시베리안',
  '싱가푸라',
  '아메리칸 밥테일',
  '아메리칸 숏헤어',
  '아메리칸 와이어헤어',
  '아메리칸 컬',
  '아비시니안',
  '아시안',
  '오리엔탈',
  '오스트레일리안 미스트',
  '오시캣',
  '이집션 마우',
  '재패니즈 밥테일',
  '중모종 믹스',
  '카오 마니',
  '코니시 렉스',
  '코랏',
  '코리안숏헤어',
  '쿠리리안 밥테일',
  '킴릭',
  '터키쉬 반',
  '터키쉬 아고라',
  '톤키니즈',
  '페르시안',
  '피터볼드',
  '픽시 밥',
  '하바나'
];
final pet_explain_text_list = [
  '성장기 강아지들에게 풍성한 자양분 섭취는 필수적이에요.특히 신체를 구성하고 면역력을 높여주는 단백질과 성장하는데 필요한 에너지를 위한 높은 열량은 필수 요소입니다. 성장기 반려견을 위한 고단백 고열량으로 설계된 퍼피 사료들을 만나보세요.',
  '성견에게 맞춰진 영양 밸런스로 설계된 사료들을 준비했습니다. 활동량이 많은 성견에게 필요한 영양소를 공급해줄 고품질의 단백질과 비타민·미네랄이 충분한 사료들을 만나보세요.',
  '성견에게 맞춰진 영양 밸런스로 설계된 사료들을 준비했습니다. BCS가 4 이상인 아이들의 경우에는 전반적인 건강관리를 위해 다이어트가 필수에요. 성견에게 필요한 영양소는 모두 채웠지만, 칼로리는 낮춘 사료들을 만나보세요.',
  '신체 대사와 활동량이 줄어드는 노령견에게는 칼로리는 낮추고 단백질은 높인 영양 설계가 필요해요. 노령견견에게 맞춰진 영양 설계 그리고 관절과 소화에 도움을 주는 성분까지 포함된 시니어 사료들을 준비했어요.',
  '신체 대사와 활동량이 줄어드는 노령견에게는 칼로리는 낮추고 단백질은 높인 영양설계가 필요해요.더불어 BCS가 4 이상인 아이들의 경우에는 건강관리를 위해 다이어트가 필수에요. 필요한 영양소는 모두 채웠지만, 칼로리는 낮춘 제품들을 만나보세요.',
  '본래 육식동물인 고양이는 많은 양의 동물성단백질 섭취가 필요해요. 또한 스스로 생성하지 못하는 타우린은 꼭 사료에 포함되어야 합니다. 이에 더해 면역력을 위한 비타민과 편안한 소화를 위한 유산균까지 포함된 사료들을 준비했어요.',
  '본래 육식동물인 고양이는 많은 양의 동물성단백질 섭취가 필요해요. 또한 스스로 생성하지 못하는 타우린은 꼭 사료에 포함되어야 합니다. 이에 더해 면역력을 위한 비타민과 편안한 소화를 위한 유산균까지 포함된 사료들을 준비했어요.',
  '성묘에게 맞춰진 영양 밸런스로 설계된 사료들을 준비했습니다. 더불어 BCS가 4 이상인 아이들의 경우에는 전반적인 건강관리를 위해 다이어트가 필수에요. 성견에게 필요한 영양소는 모두 채웠지만, 칼로리는 낮춘 사료들을 만나보세요.',
  '신체 대사와 활동량이 줄어드는 노령묘에게는 칼로리는 낮추고 단백질은 높인 영양 설계가 필요해요. 노령묘에게 맞춰진 영양 설계 그리고 관절과 소화에 도움을 주는 성분까지 포함된 시니어 사료들을 준비했어요.',
  '신체 대사와 활동량이 줄어드는 노령묘에게는 칼로리는 낮추고 단백질은 높인 영양설계가 필요해요.더불어 BCS가 4 이상인 아이들의 경우에는 건강관리를 위해 다이어트가 필수에요. 필요한 영양소는 모두 채웠지만, 칼로리는 낮춘 제품들을 만나보세요.'
];
