import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/widgets/connect_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../config/router.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/utils/space.dart';

class Connect extends StatelessWidget {
  const Connect({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchURL(String url) async {
      final Uri uri = Uri(scheme: "https", host: url);
      if (await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
        throw "Don't launch";
      }
    }

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
                  "support",
                  style: AppTextStyle.instance.w700.copyWith(
                      fontSize: FontSizeConst.instance.extraLargeFont,
                      color: AppColors.mainGreen),
                ).tr()
              ],
            ),
            HBox(10.h),
            ConnectListTile(
              title: "via_telegram".tr(),
              action: SvgPicture.asset("assets/svg/telegram.svg"),
              onTap: () {
                launchUrlString("https://t.me/Azizbek_Sultonov",
                    mode: LaunchMode.inAppBrowserView);
              },
            ),
            ConnectListTile(
              title: "via_email".tr(),
              action: SvgPicture.asset("assets/svg/email.svg"),
              onTap: ()async {
                await launchUrl(
                   Uri.parse('mailto:sultonovazizbek73@gmail.com?subject=Subject&body=Body'),
                   // mode: LaunchMode.inAppBrowserView,
                 );


              },
            ),
            ConnectListTile(
              title: "via_phone".tr(),
              action: SvgPicture.asset("assets/svg/tel.svg"),
              onTap: () async {

                  await launchUrlString("tel:",
                      mode: LaunchMode.externalApplication);

              },
            ),
          ],
        ),
      ),
    );
  }
}
