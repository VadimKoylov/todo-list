import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/features/app/theme/app_text_field_styles.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final AppTextFieldStyle? appTextFieldStyle;
  final TextEditingController controller;

  const AppTextField({
    this.appTextFieldStyle,
    required this.controller,
    Key? key,
  }) : super(key: key);

  const AppTextField.body({
    required this.controller,
    Key? key,
    this.appTextFieldStyle = const AppTextFieldStyle(
        isExpand: true,
        keyboardType: TextInputType.multiline,
        hint: 'Add description',
        height: 300,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color:colors.mainWhite,
        )),
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    var textFieldStyle = widget.appTextFieldStyle ??
        Theme.of(context).extension<AppTextFieldStyles>()!.appTextFieldStyle;
    return Container(
      width: double.maxFinite,
      height: textFieldStyle.height,
      decoration: BoxDecoration(
        color: context.appColors.darkGrey,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: textFieldStyle.keyboardType,
        style: textFieldStyle.textStyle,
        expands: textFieldStyle.isExpand,
        inputFormatters: <TextInputFormatter>[
          UpperCaseTextFormatter()
        ],
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: context.appColors.mainBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: context.appColors.mainBlack,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          isDense: true,
          hintText: textFieldStyle.hint,
          hintStyle: TextStyle(color: context.appColors.white24),
        ),
        maxLines: textFieldStyle.isExpand ? null : 1,
      ),
    );
  }
}

class AppTextFieldStyle {
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final bool isExpand;
  final String? hint;
  final double? height;

  const AppTextFieldStyle({
    this.keyboardType,
    this.textStyle,
    this.isExpand = false,
    this.hint,
    this.height,
  });

  static AppTextFieldStyle? lerp(
      AppTextFieldStyle? a, AppTextFieldStyle? b, t) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;
    return AppTextFieldStyle(
      keyboardType: t < 0.5 ? a.keyboardType : b.keyboardType,
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t)!,
      isExpand: t < 0.5 ? a.isExpand : b.isExpand,
      hint: t < 0.5 ? a.hint : b.hint,
      height: t < 0.5 ? a.height : b.height,
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}
String capitalize(String value) {
  if(value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
