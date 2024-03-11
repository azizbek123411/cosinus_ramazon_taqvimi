import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';

import '../../config/appColors.dart';
import '../../config/font_size.dart';
import '../../repository/constants/text_styles.dart';
import '../../repository/utils/app_padding.dart';
class ConnectListTile extends StatelessWidget {
  String title;
  Widget action;
  void Function() onTap;
   ConnectListTile({super.key,required this.title,
  required this.action,
   required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dis.only(tb: 8.h),
      width: 345.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.colorF4DEBD,
      ),
      child: ListTile(
        onTap: onTap,
        leading: action,
        title: Text(
          title,
          style: AppTextStyle.instance.w700.copyWith(
            color: AppColors.mainGreen,
            fontSize: FontSizeConst.instance.mediumFont,
          ),
        ),

      ),
    );;
  }
}
