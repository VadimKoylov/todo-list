import 'package:flutter/material.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;
import 'package:todo/features/app/theme/app_colors.dart';
import 'package:todo/features/app/theme/app_text_styles.dart';

abstract class AppTheme {
  static ThemeData themeData = ThemeData.light().copyWith(
    extensions: [
      const AppColors(
        mainWhite:colors.mainWhite,
        white24:colors.white24,
        mainGrey:colors.mainGrey,
        darkGrey:colors.darkGrey,
        mainBlack:colors.mainBlack,
        mainBlue:colors.mainBlue,
        mainPurple:colors.mainPurple,
      ),
      const AppTextStyles(
        inter14Reg: inter14Reg,
        inter14LineThrough: inter14LineThrough,
      ),
    ],
  );
}
