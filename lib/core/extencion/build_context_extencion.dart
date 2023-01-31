import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

extension BuildContextExtencion on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
}
