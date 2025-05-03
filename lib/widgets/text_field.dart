import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  const TextFieldButton({
    super.key,
    required this.hintText,
    required this.controllerText,
    required this.isPassword,
  });
  final String hintText;
  final bool isPassword;
  final TextEditingController controllerText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controllerText,
      validator: (controllerText) {
        if (controllerText == null || controllerText.isEmpty) {
          return "Can't be null";
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.whiteColor),
        ),
        hintText: hintText,
        hintStyle: AppTextStyles.pacificoRegular.copyWith(fontSize: 16),
      ),
    );
  }
}
