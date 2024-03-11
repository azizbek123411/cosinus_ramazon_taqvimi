import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/space.dart';

import '../../config/appColors.dart';
import '../../config/font_size.dart';
import '../../repository/constants/text_styles.dart';
import '../../repository/utils/app_padding.dart';

class BottomSheetHOme extends StatelessWidget {
  String whichPray;
  String arabicPray;
  String latinPray;
  String meaningPray;
  double h;

  BottomSheetHOme({super.key,
    required this.whichPray,
    required this.h,
    required this.arabicPray,
    required this.latinPray,
    required this.meaningPray});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dis.only(
        top: 10.h,
        lr: 15.w,
        bottom: 20.h,
      ),
      height: h,
      decoration: BoxDecoration(
        gradient: AppColors.mainGreenGradient,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              whichPray,
              style: AppTextStyle.instance.w700.copyWith(
                fontSize: FontSizeConst.instance.extraLargeFont,
                color: AppColors.whiteColor,
              ),
            ),
            const Divider(color: Colors.green),
            Text(
           arabicPray,
              style: AppTextStyle.instance.w600.copyWith(
                fontSize: FontSizeConst.instance.mediumFont,
                color: AppColors.whiteColor,
              ),
            ),
            HBox(15.h),
            Text(
              latinPray,
              style: AppTextStyle.instance.w600.copyWith(
                fontSize: FontSizeConst.instance.mediumFont,
                color: AppColors.whiteColor,
              ),
            ),
            HBox(15.h),
            Text(
             meaningPray,
              style: AppTextStyle.instance.w600.copyWith(
                fontSize: FontSizeConst.instance.mediumFont,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
