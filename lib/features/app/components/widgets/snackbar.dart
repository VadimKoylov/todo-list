import 'package:flutter/material.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;

class AppSnackBar {
  static void showSnackBar(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 10,
        bottom: 10,
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color:colors.mainWhite,
        ),
      ),
      backgroundColor:colors.mainBlack,
      behavior: SnackBarBehavior.fixed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
