import 'package:chat_app/resources/app_text_styles.dart';
import 'package:chat_app/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    super.key,
    required this.text,
    required this.registerType,
    required this.onPressed,
  });
  final String text;
  final String registerType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          registerType,
          style: AppTextStyles.pacificoRegular.copyWith(fontSize: 16),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: AppTextStyles.pacificoRegular.copyWith(
              color: ColorsManager.logoColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
