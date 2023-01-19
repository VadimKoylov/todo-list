import 'package:flutter/material.dart';
import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/features/app/theme/app_checkbox_list_tile_styles.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;

class AppCheckboxListTile extends StatelessWidget {
  final void Function(bool?) onChanged;
  final CheckboxListTileStyle? checkboxListTileStyle;
  final String title;
  final String description;
  final bool initialValue;

  const AppCheckboxListTile({
    required this.onChanged,
    this.checkboxListTileStyle,
    required this.title,
    required this.description,
    required this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = checkboxListTileStyle ??
        Theme.of(context)
            .extension<CheckboxListTileStyles>()!
            .checkboxListTileStyle;
    return SizedBox(
      height: 50,
      child: CheckboxListTile(
        activeColor: context.appColors.mainPurple,
        checkboxShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: style.textStyle),
            if (description.isNotEmpty)
              Text(description, style: style.textStyle),
          ],
        ),
        value: initialValue,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        side: const BorderSide(color: colors.mainWhite, width: 2),
      ),
    );
  }
}

class CheckboxListTileStyle {
  final TextStyle textStyle;

  const CheckboxListTileStyle({required this.textStyle});

  static CheckboxListTileStyle? lerp(
    CheckboxListTileStyle? a,
    CheckboxListTileStyle? b,
    double t,
  ) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;
    return CheckboxListTileStyle(
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t)!,
    );
  }
}
