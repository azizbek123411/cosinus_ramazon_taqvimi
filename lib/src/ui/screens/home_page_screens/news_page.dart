import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/font_size.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/constants/text_styles.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/space.dart';

import '../../../config/appColors.dart';
import '../../../config/router.dart';

class Newspage extends StatefulWidget {
  const Newspage({super.key});

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: Dis.all(6),
          child: CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: IconButton(
              onPressed: () {
                AppRouter.close(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.mainGreen,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: Dis.only(lr: 20.w, tb: 10.h),
        child: Column(
          children: [
            Text(
              "news_title",
              style: AppTextStyle.instance.w700.copyWith(
                fontSize: FontSizeConst.instance.largeFont,
                color: AppColors.mainGreen,
              ),
            ).tr(),
            HBox(20.h),
            Text(
              "news_body",
              style: AppTextStyle.instance.w700.copyWith(
                fontSize: FontSizeConst.instance.smallFont,
                color: AppColors.greyColor,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
