import 'dart:async';
import 'dart:developer';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/providers/times_provider.dart';
import '../../../repository/utils/app_padding.dart';
import '../../../repository/utils/space.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/home_appbar.dart';
import '../../widgets/main_green_button.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

String _currentTime = '';
double _progress = 0.0;
bool _isSaharlik = false;

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    DateTime now = DateTime.now();
    DateTime iftorlikVaqt = _calculateIftorlikVaqt(now);
    DateTime saharlikVaqt = _calculateSaharlikVaqt(now);
    Duration remainingTime;

    if (now.isBefore(saharlikVaqt)) {
      _isSaharlik = true;
      remainingTime = saharlikVaqt.difference(now);
    } else if (now.isBefore(iftorlikVaqt)) {
      _isSaharlik = false;
      remainingTime = iftorlikVaqt.difference(now);
    } else {
      _isSaharlik = true;
      remainingTime = saharlikVaqt.add(const Duration(days: 1)).difference(now);
    }

    setState(() {
      _currentTime =
      '${remainingTime.inHours}:${remainingTime.inMinutes.remainder(60)}:${remainingTime.inSeconds.remainder(60)}';
      _progress = 1 - (remainingTime.inSeconds / Duration.secondsPerDay);
    });
  }
  @override
  void dispose() {
    _updateTime();
    super.dispose();
  }

  DateTime _calculateSaharlikVaqt(DateTime now) {
    return DateTime(now.year, now.month, now.day, 5, 27);
  }

  DateTime _calculateIftorlikVaqt(DateTime now) {
    return DateTime(now.year, now.month, now.day, 18, 30);
  }

  final _myBox = Hive.box("address");

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(namozTimes);
    int dayIndex = DateTime.now().day - 1;
    int thisdayIndex = DateTime.now().day ;

    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 110.h),
        child: const HomeAppBar(),
      ),
      body: Padding(
        padding: Dis.only(lr: 20.w),
        child: SingleChildScrollView(
          child: provider.when(data: (data) {
            return Column(
              children: [
                HBox(13.h),
                SizedBox(
                  height: 90.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      data.removeWhere(
                              (element) => element!.date.day < dayIndex);
                      return Padding(
                        padding: Dis.only(lr: 4.w),
                        child: GestureDetector(
                          onTap: () {
                              setState(() {
                                thisdayIndex=data[index]!.date.day;
                              });
                            print(thisdayIndex);
                          },
                          child: Container(
                            height:thisdayIndex != data[index]!.date.day
                                ? 72.h
                                : 90.h,
                            width:
                            thisdayIndex != data[index]!.date.day? 75.w : 100.w,
                            decoration: BoxDecoration(
                              color:thisdayIndex != data[index]!.date.day
                                  ? AppColors.colorF4DEBD
                                  : AppColors.mainGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data[index]?.date.day.toString() ?? "",
                                  style:thisdayIndex !=
                                      data[index]!.date.day
                                      ? AppTextStyle.instance.w700.copyWith(
                                    fontSize:
                                    FontSizeConst.instance.smallFont,
                                    color: AppColors.blackColor,
                                  )
                                      : AppTextStyle.instance.w700.copyWith(
                                      fontSize:
                                      FontSizeConst.instance.mediumFont,
                                      color: AppColors.whiteColor),
                                ),
                                Text(data[index]?.weekday ?? "",
                                    style: thisdayIndex !=
                                        data[index]!.date.day
                                        ? AppTextStyle.instance.w700.copyWith(
                                      fontSize: FontSizeConst
                                          .instance.extraSmallFont,
                                      color: AppColors.blackColor,
                                    )
                                        : AppTextStyle.instance.w700.copyWith(
                                        fontSize: FontSizeConst
                                            .instance.mediumFont,
                                        color: AppColors.whiteColor)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
                                _isSaharlik ? "for_saharlik":"for_open_mouth" ,
                                style: AppTextStyle.instance.w400.copyWith(
                                    fontSize: FontSizeConst.instance.mediumFont,
                                    color: AppColors.blackColor),
                              ).tr(),
                              Text(
                                _currentTime,
                                style: AppTextStyle.instance.w700.copyWith(
                                    fontSize:
                                    FontSizeConst.instance.extraLargeFont,
                                    color: AppColors.blackColor),
                              ),
                            ],
                          ),
                          radius: 130.h,
                          lineWidth: 30,
                          percent: _progress,
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
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BottomSheetHOme(
                                      h: 440.h,
                                      whichPray: 'close_mouth_pray'.tr(),
                                      arabicPray:
                                      'اَللَّهُمَّ لَكَ صُمْتُ وَ بِكَ آمَنْتُ وَ عَلَيْكَ تَوَكَّلْتُ وَ عَلَى رِزْقِكَ أَفْتَرْتُ، فَغْفِرْلِى مَا قَدَّمْتُ وَ مَا أَخَّرْتُ بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِينَ',
                                      latinPray: 'open_mouth_pray_latin'.tr(),
                                      meaningPray:
                                      'open_mouth_pray_meaning'.tr(),
                                    );
                                  });
                            },
                            h: 70.h,
                            w: 140.w,
                            radius: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  data[thisdayIndex - 15]!.saharlik.toString(),
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
                                    meaningPray:
                                    'close_mouth_pray_meaning'.tr(),
                                  );
                                },
                              );
                            },
                            h: 70.h,
                            w: 140.w,
                            radius: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  data[thisdayIndex - 15]?.shom.toString() ?? "",
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
           log(error.toString(),stackTrace: st);
          }, loading: () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainGreen,
                    ),
                  )
                ],
            );
          }),
        ),
      ),
    );
  }
}
