import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cosinus_ramazon_taqvimi/src/config/router.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/nav_bar_pages/main_nav_page.dart';

import '../../../config/appColors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      AppRouter.id(context, MainNavpage.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/image2.png"),
                fit: BoxFit.cover),
            color: AppColors.mainGreen),
        child: Center(
          child: SvgPicture.asset(
            "assets/svg/sunset.svg",
            height: 100,
          ),
        ),
      ),
    );
  }
}
