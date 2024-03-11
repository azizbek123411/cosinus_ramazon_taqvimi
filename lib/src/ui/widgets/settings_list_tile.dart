import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';

import '../../config/appColors.dart';
import '../../config/font_size.dart';
import '../../repository/constants/text_styles.dart';
import '../../repository/utils/app_padding.dart';
class SettingsListTile extends StatelessWidget {
  void Function() onTap;
  String title;
  Widget trailing;
  SettingsListTile({super.key,required this.trailing,
    required this.onTap,
  required this.title});

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
        leading: SvgPicture.asset("assets/svg/sunset.svg"),
        title: Text(
          title,
          style: AppTextStyle.instance.w700.copyWith(
            color: AppColors.blackColor,
            fontSize: FontSizeConst.instance.mediumFont,
          ),
        ),

        trailing: trailing,
      ),
    );
  }
}
