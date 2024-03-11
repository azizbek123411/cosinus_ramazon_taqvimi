import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/widgets/notificagtion_card.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../config/router.dart';
import '../../../repository/constants/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:   Padding(
          padding: Dis.all(5),
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
        title: Text(
          "news",
          style: AppTextStyle.instance.w700.copyWith(
              fontSize: FontSizeConst.instance.extraLargeFont,
              color: AppColors.mainGreen),
        ).tr(),
      ),
      backgroundColor: AppColors.mainBackground,
      body: Padding(
        padding: Dis.only(lr: 20.w,tb: 10.h),
        child:const SingleChildScrollView(
          child: Column(
            children: [
              NotificationCard(),
              NotificationCard(),
              NotificationCard(),
            ],
          ),
        ),
      ),
    );
  }
}
