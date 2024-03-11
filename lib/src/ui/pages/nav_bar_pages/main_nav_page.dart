import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/nav_bar_pages/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/utils/app_padding.dart';
import 'home_page.dart';
import 'masjids_page.dart';
import 'namoz_time_page.dart';

class MainNavpage extends StatefulWidget {
  static const String id = 'main';

  const MainNavpage({super.key});

  @override
  State<MainNavpage> createState() => _MainNavpageState();
}

class _MainNavpageState extends State<MainNavpage> {
  int currentIndex = 0;
  List screens = [
    const HomePage(),
    const NamozTime(),
    const MasjidsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 83.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.mainGreen,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          selectedLabelStyle: AppTextStyle.instance.w500.copyWith(
              fontSize: FontSizeConst.instance.smallFont,
              color: AppColors.whiteColor),
          backgroundColor: AppColors.mainGreen,
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              label: "navbar_home".tr(),
              icon: Padding(
                padding: Dis.only(tb: 8.h),
                child: SvgPicture.asset("assets/svg/lanterns 1.svg"),
              ),
            ),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
              label: "namoz_time".tr(),
              icon: Padding(
                padding: Dis.only(tb: 8.h),
                child: SvgPicture.asset("assets/svg/ramadan-_1_ 1.svg"),
              ),
            ),
            BottomNavigationBarItem(backgroundColor: Colors.transparent,
              label: "navbar_masjid".tr(),
              icon: Padding(
                padding: Dis.only(tb: 8.h),
                child: SvgPicture.asset("assets/svg/mosque-_1_ 1.svg"),
              ),
            ),
            BottomNavigationBarItem(backgroundColor: Colors.transparent,
              label: "settings".tr(),
              icon: Padding(
                padding: Dis.only(tb: 8.h),
                child: SvgPicture.asset("assets/svg/Frame.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
