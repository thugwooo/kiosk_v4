import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'screens/basic_form.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'fe6c21442e9449a368a795b912768a34');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return ScreenUtilInit(
        designSize: Size(600, 450),
        builder: ((context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'NotoSansKR',
              backgroundColor: Colors.white,
            ),
            home: BasicForm(),
          );
        }));
  }
}
