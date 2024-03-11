import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/router.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/screens/home_page_screens/news_page.dart';

import '../../config/appColors.dart';
import '../../config/font_size.dart';
import '../../repository/constants/text_styles.dart';
import '../../repository/utils/app_padding.dart';
class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
AppRouter.go(context, const Newspage());
      },
      child: Container(
        margin: Dis.only(tb: 8),
        padding: Dis.only(lr: 7.w,tb: 5.h),
        height: 68.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.colorF4DEBD,
            ),
        child: Text(
          "news_title",
          style: AppTextStyle.instance.w700.copyWith(

            fontSize: FontSizeConst.instance.mediumFont,
            color: AppColors.blackColor,
          ),
          maxLines: 4,
        ).tr(),
      ),
    );
  }
}
