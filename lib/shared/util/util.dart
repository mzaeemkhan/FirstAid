import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/helper_models/language_model.dart';
import 'package:first_aid/shared/constants/app_colors.dart';
import 'package:first_aid/shared/constants/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

//region image from network widget
Widget networkImageNew(String url, double h, double w, BoxFit fit, Color progressColor, function){
  return CachedNetworkImage(
    imageUrl: url != null ? url : "",
    width: w,
    height: h,
    fit: fit,
    imageBuilder: (context, imageProvider) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: progressColor,)),
    errorWidget: (context, url, error) => Container(
      height: h,
      width: w,
      child: Center(
        child: Icon(
          Icons.error_rounded,
          size: 24.0,
          color: Colors.red,
        ),
      ),
    ),
  );
}
//endregion

//region Language Options
Future<List<LanguageModel>> getLanguageOptions() async {
  List<LanguageModel> languageOptions = new List<LanguageModel>.empty(growable: true);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey(StringAssets.languageOptionKey)){
    if(prefs.getString(StringAssets.languageOptionKey) != null){
      if(prefs.getString(StringAssets.languageOptionKey) != ""){
        String myList = prefs.getString(StringAssets.languageOptionKey);
        if(myList != null){
          var result = await json.decode(myList);
          var res = result as List;
          List<LanguageModel> languageModels = res.map((x) => LanguageModel.fromJson(x)).toList();
          languageOptions.addAll(languageModels);
          updateLocale(languageOptions);
          return languageOptions;
        }
      }
    }
  }

  languageOptions.add(new LanguageModel(
      id: 1,
      name: "english",
      languageCode: "en",
      countryCode: "US",
      isSelected: true
  ));
  languageOptions.add(new LanguageModel(
      id: 2,
      name: "urdu",
      languageCode: "ur",
      countryCode: "PK",
      isSelected: false
  ));

  updateLocale(languageOptions);

  return languageOptions;
}
//endregion

//region Check string validity
String checkValidString(value){
  String s = "";

  if(value != null){
    if(value.toString().trim() != ""){
      s = value.toString().trim();
    }
  }

  return s;
}
//endregion

//region Locale update
void updateLocale(List<LanguageModel> list){
  if(list != null){
    if(list.isNotEmpty){
      list.forEach((element) {
        if(element.isSelected){
          var locale = Locale(element.languageCode, element.countryCode);
          Get.updateLocale(locale);

          changeLanguageIdentifier();
        }
      });
    }
  }
}

void changeLanguageIdentifier(){
  FirstAidController firstAidController;

  try{
    firstAidController = Get.find();
  }catch(exception){
    firstAidController = Get.put(FirstAidController());
  }

  firstAidController.languageOptions.forEach((element) {
    if(element.isSelected){
      if(element.id == 1){
        firstAidController.languageEnglish = true;
      }
      else{
        firstAidController..languageEnglish = false;
      }
    }
  });
  firstAidController.update();
}
//endregion

//region Launch any url
Future<void> launchURL() async {
  String url = 'https://atrule.com';

  try{
    await launch(url);
  }catch(exception){
    errorToastMessages("Error: Could not open the link.");
  }
}
//endregion

// region Simple Toast
void simpleToastMessages(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primaryColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: ScreenUtil().setSp(16.0));
}
// endregion

// region Error Toast
void errorToastMessages(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: ScreenUtil().setSp(16.0));
}
// endregion