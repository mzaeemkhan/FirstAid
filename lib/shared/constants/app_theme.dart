import 'package:first_aid/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String getFontAccordingToLanguage(){
  return 'app_font_family'.tr;
}

ThemeData getLightThemeData(){
  return ThemeData(
    fontFamily: getFontAccordingToLanguage(),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: AppColors.whiteColor),
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      backgroundColor: AppColors.primaryColor,
      elevation: 5.0,
      toolbarTextStyle: TextStyle(
        fontSize: 16,
        color: AppColors.whiteColor,
        fontFamily: getFontAccordingToLanguage(),
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: AppColors.whiteColor,
        fontFamily: getFontAccordingToLanguage(),
      ),
    ),
    primaryColor: AppColors.primaryColor,
    textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 16,
          color: AppColors.whiteColor,
          fontFamily: getFontAccordingToLanguage(),
        )
    ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryLightColor
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: InputBorder.none,
        hintStyle: TextStyle(
          fontSize: 16,
          color: AppColors.primaryLightColor,
          fontFamily: getFontAccordingToLanguage(),
        )),
  );
}