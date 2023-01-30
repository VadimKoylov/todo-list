import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color mainWhite;
  final Color white24;
  final Color mainGrey;
  final Color mainPurple;
  final Color mainBlue;
  final Color mainBlack;
  final Color mainRed;
  final Color darkGrey;

  const AppColors({
    required this.mainWhite,
    required this.white24,
    required this.mainGrey,
    required this.mainPurple,
    required this.mainBlue,
    required this.mainBlack,
    required this.mainRed,
    required this.darkGrey,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? mainWhite,
    Color? white24,
    Color? mainGrey,
    Color? mainPurple,
    Color? mainBlue,
    Color? mainBlack,
    Color? mainRed,
    Color? darkGrey,
  }) =>
      AppColors(
        mainWhite: mainWhite ?? this.mainWhite,
        white24: white24 ?? this.white24,
        mainGrey: mainGrey ?? this.mainGrey,
        mainPurple: mainPurple ?? this.mainPurple,
        mainBlue: mainBlue ?? this.mainBlue,
        mainBlack: mainBlack ?? this.mainBlack,
        mainRed: mainRed ?? this.mainRed,
        darkGrey: darkGrey ?? this.darkGrey,
      );

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      mainWhite: Color.lerp(mainWhite, other.mainWhite, t)!,
      white24: Color.lerp(white24, other.white24, t)!,
      mainGrey: Color.lerp(mainGrey, other.mainGrey, t)!,
      mainPurple: Color.lerp(mainPurple, other.mainPurple, t)!,
      mainBlue: Color.lerp(mainBlue, other.mainBlue, t)!,
      mainBlack: Color.lerp(mainBlack, other.mainBlack, t)!,
      mainRed: Color.lerp(mainRed, other.mainRed, t)!,
      darkGrey: Color.lerp(darkGrey, other.darkGrey, t)!,
    );
  }
}
