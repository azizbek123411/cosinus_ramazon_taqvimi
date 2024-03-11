import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../config/router.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/utils/space.dart';

class LanguageSettings extends HookConsumerWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectRadioProvider = StateProvider((ref) {
      if (context.locale == const Locale('uz', 'UZ')) {
        return 0;
      } else if (context.locale == const Locale('ru', 'RU')) {
        return 1;
      } else if (context.locale == const Locale('en', 'EN')) {
        return 2;
      }
    });
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70.h),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainGreen,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          )),
      backgroundColor: AppColors.mainBackground,
      body: Padding(
        padding: Dis.only(lr: 20.w, tb: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
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
                WBox(10.w),
                Text(
                  "language",
                  style: AppTextStyle.instance.w700.copyWith(
                      fontSize: FontSizeConst.instance.extraLargeFont,
                      color: AppColors.mainGreen),
                ).tr()
              ],
            ),
            ListTile(
              leading: Radio(

                activeColor: AppColors.mainGreen,
                value: 0,
                groupValue: ref.watch(selectRadioProvider),
                onChanged: (value) async {
                  await context.setLocale(
                    const Locale("uz", "UZ"),
                  );
                },
              ),
              title: Text(
                "O'zbekcha (UZ)",
                style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.mediumFont,
                  color: AppColors.blackColor,
                ),
              ),
              trailing: SvgPicture.asset(
                "assets/svg/uzbekistan-flag-round-circle-icon.svg",
                height: 32.h,
                width: 32.w,
              ),
            ),
            ListTile(
              leading: Radio(
                activeColor: AppColors.mainGreen,
                value: 1,
                groupValue: ref.watch(selectRadioProvider),
                onChanged: (value) async {
                  await context.setLocale(
                    const Locale("ru", "RU"),
                  );
                },
              ),
              title: Text(
                "Русский   (RU)",
                style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.mediumFont,
                  color: AppColors.blackColor,
                ),
              ),
              trailing: SvgPicture.asset(
                  "assets/svg/russia-flag-round-circle-icon.svg",
                  height: 32.h,
                  width: 32.w),
            ),
            ListTile(
              leading: Radio(
                activeColor: AppColors.mainGreen,
                value: 2,
                groupValue: ref.watch(selectRadioProvider),
                onChanged: (value)async {
                await  context.setLocale(const Locale("en", "EN"));
                },
              ),
              title: Text(
                "English (US)",
                style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.mediumFont,
                  color: AppColors.blackColor,
                ),
              ),
              trailing: SvgPicture.asset(
                  "assets/svg/usa-flag-round-circle-icon.svg",
                  height: 32.h,
                  width: 32.w),
            ),
          ],
        ),
      ),
    );
  }
}
