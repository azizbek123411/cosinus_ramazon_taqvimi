import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/appColors.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
class  MainGreenButton extends StatelessWidget {
  double h;
  double w;
  Widget child;
  double radius;
  void Function() onTap;

   MainGreenButton({super.key,required this.h,
   required this.w,
   required this.radius,
   required this.child,
   required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Dis.only(lr: 4.w),
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: AppColors.mainGreenGradient
        ),
        child: child,
      ),
    );
  }
}
