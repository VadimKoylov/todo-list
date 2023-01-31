import 'package:flutter/material.dart';
import 'package:todo/core/presentation/widgets.dart';

class AppTextFieldStyles extends ThemeExtension<AppTextFieldStyles> {
  final AppTextFieldStyle appTextFieldStyle;

  const AppTextFieldStyles({
    required this.appTextFieldStyle,
  });

  @override
  ThemeExtension<AppTextFieldStyles> copyWith({
    AppTextFieldStyle? appTextFieldStyle,
  }) {
    return AppTextFieldStyles(
      appTextFieldStyle: appTextFieldStyle ?? this.appTextFieldStyle,
    );
  }

  @override
  ThemeExtension<AppTextFieldStyles> lerp(
      ThemeExtension<AppTextFieldStyles>? other, double t) {
    if (other is! AppTextFieldStyles) {
      return this;
    }
    return AppTextFieldStyles(
      appTextFieldStyle: AppTextFieldStyle.lerp(appTextFieldStyle, other.appTextFieldStyle, t) ??
          appTextFieldStyle,
    );
  }
}
