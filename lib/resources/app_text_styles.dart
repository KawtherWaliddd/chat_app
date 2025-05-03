import 'package:chat_app/resources/colors_manager.dart';
import 'package:flutter/widgets.dart';

class AppTextStyles {
  AppTextStyles._();
  static const TextStyle pacificoRegular = TextStyle(
    fontSize: 30,
    fontFamily: 'Pacifico',
    color: ColorsManager.whiteColor,
  );
  static const TextStyle pacificoRegularGrey = TextStyle(
    fontSize: 16,
    fontFamily: 'Pacifico',
    color: ColorsManager.primaryColor,
  );
}
