import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/app_padding.dart';
import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/widgets/settings_list_tile.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../config/router.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/utils/space.dart';
class AzonSettings extends StatelessWidget {
  const AzonSettings({super.key});

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
          )),
        backgroundColor: AppColors.mainBackground,
      body: Padding(padding: Dis.only(lr: 20.w,tb: 10.h),
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
                "azon_settings",
                style: AppTextStyle.instance.w700.copyWith(
                    fontSize: FontSizeConst.instance.extraLargeFont,
                    color: AppColors.mainGreen),
              ).tr(),
            ],
          ),
        SettingsListTile(trailing: SvgPicture.asset("assets/svg/Frame (1).svg"), onTap: (){}, title: "bomdod".tr()),
        SettingsListTile(trailing: SvgPicture.asset("assets/svg/Frame (1).svg"), onTap: (){}, title: "peshin".tr()),
        SettingsListTile(trailing: SvgPicture.asset("assets/svg/Frame (1).svg"), onTap: (){}, title: "asr".tr()),
        SettingsListTile(trailing: SvgPicture.asset("assets/svg/Frame (1).svg"), onTap: (){}, title: "shom".tr()),
        SettingsListTile(trailing: SvgPicture.asset("assets/svg/Frame (1).svg"), onTap: (){}, title: "xufton".tr()),
        ],
      ),),
    );
  }
}
