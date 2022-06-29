import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

extension TextStyleX on TextStyle {
  // Colors
  TextStyle get button => copyWith(color: AppColors.whitePrimary);

  TextStyle get primary => copyWith(color: AppColors.black);

  TextStyle get secondary => copyWith(color: AppColors.grey);

  TextStyle get grey => copyWith(color: AppColors.greyDark);

  TextStyle get accent => copyWith(color: AppColors.greenPrimary);

  TextStyle get danger => copyWith(color: AppColors.redAccent);

  // Font size
  TextStyle get p => copyWith(fontSize: 16);

  TextStyle get s => copyWith(fontSize: 14);

  TextStyle get exs => copyWith(fontSize: 12);

  TextStyle get m => copyWith(fontSize: 18);

  TextStyle get l =>
      copyWith(fontSize: (ScreenUtil().screenWidth > 1080) ? 20 : 16);

  TextStyle get exl =>
      copyWith(fontSize: (ScreenUtil().screenWidth > 1080) ? 34 : 26);

  TextStyle get exxl =>
      copyWith(fontSize: (ScreenUtil().screenWidth > 1080) ? 42 : 32);
}
