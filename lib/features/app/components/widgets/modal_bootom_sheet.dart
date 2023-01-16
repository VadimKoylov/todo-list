import 'package:flutter/material.dart';
import 'package:todo/core/assets/colors_light.dart' as colors;
import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/features/app/components/components.dart';

class AppModalBottomSheet {
  static void modalBottomSheet(BuildContext context, {
    required TextEditingController titleController,
    required TextEditingController bodyController,
    required void Function()? onPressed,
}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor:colors.mainGrey,
      context: context,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
              ),
              child: Column(
                children: [
                  AppTextField(
                    controller: titleController,
                    appTextFieldStyle: AppTextFieldStyle(
                      hint: 'Title',
                      textStyle: context.appTextStyles.inter14Reg,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppTextField.body(controller: bodyController),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.appColors.darkGrey,
                      border: Border.all(
                        color: context.appColors.mainBlack,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: onPressed,
                      child: Text(
                        'Save',
                        style: context.appTextStyles.inter14Reg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
