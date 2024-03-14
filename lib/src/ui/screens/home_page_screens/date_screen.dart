import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/appColors.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/font_size.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/constants/text_styles.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
class DateScreen extends StatelessWidget {
  String day;
  String weekday;
  void Function() onTap;
   DateScreen({super.key,required this.weekday,required this.day,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  Dis.only(tb: 5.h,lr: 13.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 72.h,
            width: 65.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.colorF4DEBD,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(day,style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.smallFont,
                  color: AppColors.blackColor,
                ),),
                Text(weekday,style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.tinyFont,
                  color: AppColors.blackColor,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
