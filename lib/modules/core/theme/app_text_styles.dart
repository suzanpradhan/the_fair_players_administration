import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_assets.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get textLight => TextStyle(
        fontSize: 16.sp,
        fontFamily: AppAssets.sfProDisplayFont,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get textRegular => TextStyle(
        fontSize: 16.sp,
        fontFamily: AppAssets.sfProDisplayFont,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get textMedium => TextStyle(
        fontSize: 16.sp,
        fontFamily: AppAssets.sfProDisplayFont,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get textSemiBold => TextStyle(
        fontSize: 16.sp,
        fontFamily: AppAssets.sfProDisplayFont,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get textBold => TextStyle(
        fontSize: 16.sp,
        fontFamily: AppAssets.sfProDisplayFont,
        fontWeight: FontWeight.bold,
      );
}
