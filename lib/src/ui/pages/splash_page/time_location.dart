import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/router.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/nav_bar_pages/main_nav_page.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/utils/app_padding.dart';
import '../../../repository/utils/space.dart';
import '../../widgets/main_green_button.dart';

class TimeLocation extends StatefulWidget {
  static TextEditingController controller = TextEditingController();
  static const String id = 'time';

  const TimeLocation({super.key});

  @override
  State<TimeLocation> createState() => _TimeLocationState();
}

class _TimeLocationState extends State<TimeLocation> {
    final _myBox=Hive.box("address");


  @override
  Widget build(BuildContext context) {

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
          ),),
      backgroundColor: AppColors.mainBackground,
      body: Padding(
        padding: Dis.only(lr: 20.w, tb: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WBox(10.w),
              Text(
                "time_settings",
                style: AppTextStyle.instance.w700.copyWith(
                    fontSize: FontSizeConst.instance.extraLargeFont,
                    color: AppColors.mainGreen),
              ).tr(),
              HBox(10.h),
              Text(
                "your_location",
                style: AppTextStyle.instance.w700.copyWith(
                  fontSize: FontSizeConst.instance.mediumFont,
                  color: AppColors.mainGreen,
                ),
              ).tr(),
              HBox(10.h),
              TextField(readOnly: true,
                controller: TimeLocation.controller,
                decoration: InputDecoration(
                  suffixIcon: PopupMenuButton(
                    surfaceTintColor:AppColors.mainBackground,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    onSelected: (value){
                      setState(() {
                        TimeLocation.controller.text=value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return const [
                        PopupMenuItem(
                          value: 'Andijon',
                          child: Text("Andijon"),
                        ),
                        PopupMenuItem(
                          value: 'Buxoro',
                          child: Text("Buxoro"),
                        ),
                        PopupMenuItem(
                          value: "Farg'ona",
                          child: Text("Farg'ona"),
                        ),
                        PopupMenuItem(
                          value: 'Jizzax',
                          child: Text("Jizzax"),
                        ),
                        PopupMenuItem(
                          value: 'Namangan',
                          child: Text("Namangan"),
                        ),
                        PopupMenuItem(
                          value: 'Qashqadaryo',
                          child: Text("Qashqadaryo"),
                        ),
                        PopupMenuItem(
                          value: 'Samarqand',
                          child: Text("Samarqand"),
                        ),
                        PopupMenuItem(
                          value: 'Guliston',
                          child: Text("Sirdaryo"),
                        ),
                        PopupMenuItem(
                          value: 'Surxondaryo',
                          child: Text("Surxondaryo"),
                        ),
                        PopupMenuItem(
                          value: 'Toshkent',
                          child: Text("Toshkent"),
                        ),
                        PopupMenuItem(
                          value: 'Xiva',
                          child: Text("Xorazm"),
                        ),
                        PopupMenuItem(
                          value: 'Nukus',
                          child: Text("Nukus"),
                        ),
                      ];
                    },
                  ),
                  // hintText: TimeLocation.controller.text,
                  hintText: TimeLocation.controller.text,
                  hintStyle: AppTextStyle.instance.w500.copyWith(
                      color: AppColors.mainGreen,
                      fontSize: FontSizeConst.instance.mediumFont),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              HBox(470.h),
              MainGreenButton(
                  h: 48.h,
                  w: double.infinity,
                  radius: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svg/localization.svg"),
                      Text(
                        "detect_location",
                        style: AppTextStyle.instance.w700.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: FontSizeConst.instance.mediumFont),
                      ).tr(),
                    ],
                  ),
                  onTap: () {
                    _myBox.put(1, TimeLocation.controller.text);
                    if (TimeLocation.controller.text.isNotEmpty) {
                      AppRouter.id(context, MainNavpage.id);
                    } else {}
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
