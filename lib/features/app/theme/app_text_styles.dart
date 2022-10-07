import 'package:flutter/material.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;

const TextStyle inter14Reg = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color:colors.mainWhite,
);
const TextStyle inter14LineThrough = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color:colors.mainWhite,
  decoration: TextDecoration.lineThrough,
);

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle inter14Reg;
  final TextStyle inter14LineThrough;

  const AppTextStyles({
    required this.inter14Reg,
    required this.inter14LineThrough,
  });

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? inter14Reg,
    TextStyle? inter14LineThrough,
  }) {
    return AppTextStyles(
      inter14Reg: inter14Reg ?? this.inter14Reg,
      inter14LineThrough: inter14LineThrough ?? this.inter14LineThrough,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
      ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      inter14Reg: TextStyle.lerp(inter14Reg, other.inter14Reg, t)!,
      inter14LineThrough: TextStyle.lerp(
        inter14LineThrough,
        other.inter14LineThrough,
        t,
      )!,
    );
  }
}
