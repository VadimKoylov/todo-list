import 'package:flutter/material.dart';
import 'package:todo/core/presentation/widgets.dart';

class CheckboxListTileStyles extends ThemeExtension<CheckboxListTileStyles> {
  final CheckboxListTileStyle checkboxListTileStyle;

  const CheckboxListTileStyles({
    required this.checkboxListTileStyle,
  });

  @override
  ThemeExtension<CheckboxListTileStyles> copyWith({
    CheckboxListTileStyle? checkboxListTileStyle,
  }) {
    return CheckboxListTileStyles(
      checkboxListTileStyle: checkboxListTileStyle ?? this.checkboxListTileStyle,
    );
  }

  @override
  ThemeExtension<CheckboxListTileStyles> lerp(
      ThemeExtension<CheckboxListTileStyles>? other, double t) {
    if (other is! CheckboxListTileStyles) {
      return this;
    }
    return CheckboxListTileStyles(
      checkboxListTileStyle: CheckboxListTileStyle.lerp(checkboxListTileStyle, other.checkboxListTileStyle, t) ??
          checkboxListTileStyle,
    );
  }
}
