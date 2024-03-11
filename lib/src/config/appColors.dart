import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{
static Color mainGreen=const Color(0xff103C28);
static Color whiteColor=Colors.white;
static Color blackColor=Colors.black;
static Color greyColor=Color(0xff575757);
static Color mainBackground=const Color(0xfffef8e2);
static Color colorF4DEBD=const Color(0xffF4DEBD);
static LinearGradient mainGreenGradient=LinearGradient(
  begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
   const  Color(0xff103C28),
  Colors.green.shade900,
]);
}