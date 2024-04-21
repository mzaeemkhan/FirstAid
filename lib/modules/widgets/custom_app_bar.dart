import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget customAppBar(String name, IconData icon, Function() onPressed, List<Widget> list, PreferredSizeWidget bottom){
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    elevation: 0.5,
    iconTheme: IconThemeData(
      color: AppColors.whiteColor, //change your color here
    ),
    centerTitle: true,
    leading: IconButton(
      icon: Icon(icon, size: 24.0,),
      onPressed: onPressed,
    ),
    actions: list,
    title: myText(name, TextAlign.left, AppColors.whiteColor, 16.0, FontWeight.bold),
    bottom: bottom,
  );
}