


import 'dart:async';
import 'dart:math';

import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/providers/times_provider.dart';
import '../../../repository/utils/app_padding.dart';
import '../../../repository/utils/space.dart';
import '../../screens/home_page_screens/date_screen.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/home_appbar.dart';
import '../../widgets/main_green_button.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}



class _HomePageState extends ConsumerState<HomePage> {
  double percent=0;
  late Timer timer;
 static  DateTime saharTime=DateTime(2024,3,12,4,20);
  final untilSahar=saharTime.difference(DateTime.now());
  _startTimer(){
    int timeInMinut=10;
   int time=timeInMinut*60;
    double secPercent=(time/100);
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(time>0){
          time--;
          if(time%60==0){
            timeInMinut--;
          }if(time%secPercent==0){
            if(percent<1){
              percent+=0.1;
            }else{
              percent=1;
            }
          }
        }else{
          percent=0;
          timeInMinut=10;
          timer.cancel();
        }
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  String formatDuration(Duration duration){
    final hours=duration.inHours;
    final minutes=duration.inMinutes;
    return "$hours : $minutes";
  }
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(namozTimes);
    int dayIndex=DateTime.now().day-1;
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 110.h),
        child: const HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dis.only(lr: 20.w),
          child: provider.when(data: (data) {
            return Column(
              children: [
                HBox(13.h),
                SizedBox(
                  height: 90.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {

                         data.removeWhere((element)=> element!.date.day<dayIndex);



                             return DateTime.now().day != data[index]!.date.day
                                ? DateScreen(
                              weekday: data[index]!.weekday,
                              day: data[index]!.date.day.toString(),
                              onTap: () {
                                setState(() {
                                  dayIndex=data[index]!.date.day;

                                });
                                log(dayIndex);
                              },
                            )
                                : MainGreenButton(
                                h: 72.h,
                                w: 106.w,
                                radius: 8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data[index]!.date.day.toString(),
                                      style: AppTextStyle.instance.w700
                                          .copyWith(
                                          fontSize: FontSizeConst
                                              .instance.largeFont,
                                          color: AppColors.whiteColor),
                                    ),
                                    Text(
                                      data[index]!.weekday,
                                      style: AppTextStyle.instance.w700
                                          .copyWith(
                                          fontSize: FontSizeConst
                                              .instance.extraSmallFont,
                                          color: AppColors.whiteColor),
                                    ),
                                  ],
                                ),
                                onTap: () {});

                      },
                    // itemCount: 7,
                      ),
                ),
                HBox(16.h),
                Container(
                  padding: Dis.only(tb: 16.h),
                  height: 500.h,
                  width: 345.w,
                  decoration: BoxDecoration(
                    color: AppColors.colorF4DEBD,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "ramadan_month",
                        style: AppTextStyle.instance.w700.copyWith(
                            fontSize: FontSizeConst.instance.extraLargeFont,
                            color: AppColors.blackColor),
                      ).tr(),
                      Padding(
                        padding: Dis.only(tb: 14.h),
                        child: CircularPercentIndicator(
                          linearGradient: AppColors.mainGreenGradient,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "for_open_mouth",
                                style: AppTextStyle.instance.w400.copyWith(
                                    fontSize: FontSizeConst.instance.mediumFont,
                                    color: AppColors.blackColor),
                              ).tr(),
                              Text(
                                "08:03",
                                style: AppTextStyle.instance.w700.copyWith(
                                    fontSize:
                                        FontSizeConst.instance.extraLargeFont,
                                    color: AppColors.blackColor),
                              ),
                            ],
                          ),
                          radius: 130.h,
                          lineWidth: 30,
                          percent: percent,
                          animateFromLastPercent: true,
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.green.shade200,
                        ),
                      ),
                      HBox(20.h),
                  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         MainGreenButton(
                           onTap: () {
                             if(int.parse(data[dayIndex]!.saharlik.split("")[0])==0){
                               print(true);
                             }else{
                               print(false);
                               print(formatDuration(untilSahar));
                             }
                             print(data[dayIndex]!.xufton.split("")[0]+data[dayIndex]!.xufton.split("")[1]);
                             showModalBottomSheet(
                                 context: context,
                                 builder: (BuildContext context) {
                                   return BottomSheetHOme(
                                     h: 440.h,
                                     whichPray: 'close_mouth_pray'.tr(),
                                     arabicPray:
                                         'اَللَّهُمَّ لَكَ صُمْتُ وَ بِكَ آمَنْتُ وَ عَلَيْكَ تَوَكَّلْتُ وَ عَلَى رِزْقِكَ أَفْتَرْتُ، فَغْفِرْلِى مَا قَدَّمْتُ وَ مَا أَخَّرْتُ بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِينَ',
                                     latinPray: 'open_mouth_pray_latin'.tr(),
                                     meaningPray: 'open_mouth_pray_meaning'.tr(),
                                   );
                                 });
                           },
                           h: 70.h,
                           w: 150.w,
                           radius: 8,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Text(
                                 data[dayIndex]!.saharlik.toString(),
                                 style: AppTextStyle.instance.w700.copyWith(
                                     fontSize:
                                     FontSizeConst.instance.mediumFont,
                                     color: AppColors.whiteColor),
                               ),
                               Text(
                                 "close_mouth_pray",
                                 style: AppTextStyle.instance.w700.copyWith(
                                   fontSize: FontSizeConst.instance.smallFont,
                                   color: AppColors.whiteColor,
                                 ),
                               ).tr()
                             ],
                           ),
                         ),
                         MainGreenButton(
                           onTap: () {
                             showModalBottomSheet(
                               context: context,
                               builder: (BuildContext context) {
                                 return BottomSheetHOme(
                                   h: 400.h,
                                   whichPray: 'open_mouth_pray'.tr(),
                                   arabicPray:
                                       'نَوَيْتُ أَنْ أَصُومَ صَوْمَ شَهْرَ رَمَضَانَ مِنَ الْفَجْرِ إِلَى الْمَغْرِبِ، خَالِصًا لِلهِ تَعَالَى أَللهُ أَكْبَرُ',
                                   latinPray: 'close_mouth_pray_latin'.tr(),
                                   meaningPray: 'close_mouth_pray_meaning'.tr(),
                                 );
                               },
                             );
                           },
                           h: 70.h,
                           w: 150.w,
                           radius: 8,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Text(
                                 data[dayIndex]!.xufton.toString(),
                                 style: AppTextStyle.instance.w700.copyWith(
                                     fontSize:
                                     FontSizeConst.instance.mediumFont,
                                     color: AppColors.whiteColor),
                               ),
                               Text(
                                 "open_mouth_pray".tr(),
                                 style: AppTextStyle.instance.w700.copyWith(
                                   fontSize: FontSizeConst.instance.smallFont,
                                   color: AppColors.whiteColor,
                                 ),
                               )
                             ],
                           ),
                         ),
                       ],
                     )
                    ],
                  ),
                )
              ],
            );
          }, error: (error, st) {
            return Center(
              child: Text(
                error.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            );
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
