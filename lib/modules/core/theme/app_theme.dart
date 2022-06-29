import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_text_styles.dart';

import 'app_colors.dart';
import '../extensions/widget_extensions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.whiteShade,
        drawerTheme: const DrawerThemeData(
            backgroundColor: AppColors.whitePrimary, elevation: 0),
        dividerColor: AppColors.greyLight,
        iconTheme: const IconThemeData(color: AppColors.grey),
        cardColor: AppColors.whitePrimary,
        primaryColor: AppColors.greenPrimary,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.textBold.primary.exxl,
          labelMedium: AppTextStyles.textRegular.button.m,
          bodyLarge: AppTextStyles.textRegular.primary.l,
          bodyMedium: AppTextStyles.textRegular.primary.p,
          labelLarge: AppTextStyles.textRegular.secondary.p,
          labelSmall: AppTextStyles.textRegular.secondary.exs,
          titleLarge: AppTextStyles.textBold.primary.exl,
        ));
  }
}
