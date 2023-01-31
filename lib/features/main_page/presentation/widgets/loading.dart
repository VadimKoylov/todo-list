import 'package:flutter/material.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.mainGrey,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
