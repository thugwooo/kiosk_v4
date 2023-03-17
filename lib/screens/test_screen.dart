import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk_v4/components/style.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('견종', style: curation_subtitle_style),
              Container(
                width: 50.w,
                height: 10.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
