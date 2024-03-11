import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/appColors.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/font_size.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/constants/text_styles.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';

class NamozListTile extends StatelessWidget {
  Widget actionIcon;
  String namozTiming;
  String hours;
  Color color;
  NamozListTile({
    super.key,
    required this.hours,
    required this.namozTiming,
    required this.actionIcon,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dis.only(tb: 8.h),
      width: 345.w,
      height: 75.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      child: ListTile(
        leading: SvgPicture.asset("assets/svg/sunset.svg"),
        title: Text(
          namozTiming,
          style: AppTextStyle.instance.w500.copyWith(
            color: AppColors.blackColor,
            fontSize: FontSizeConst.instance.smallFont,
          ),
        ),
        subtitle: Text(
          hours,
          style: AppTextStyle.instance.w700.copyWith(
            color: AppColors.blackColor,
            fontSize: FontSizeConst.instance.mediumFont,
          ),
        ),
        trailing: actionIcon,
      ),
    );
  }
}
