import 'dart:async';
import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/data/local/shared_preference/shared_prefs.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../modules/widgets/common_widgets.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/constants/string_assets.dart';
import '../home/main_page.dart';
import '../setting/language_selection.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirstAidController firstAidController = Get.put(FirstAidController());

  // region initState Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToNext();
  }
  // endregion

  // region build
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
          color: AppColors.whiteColor,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Lottie.asset(
                  ImageAssets.lottieAnimation,
                  repeat: true,
                  reverse: true,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circleAvatarWidget(ImageAssets.iconAtruleLogo, BoxFit.cover),
                    SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: myText(StringAssets.textAtrule, TextAlign.start, AppColors.logoColor, 16, FontWeight.normal),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // endregion

  // region goTo Next Method
  Future<void> goToNext() async {
    bool boolValue = await SharedPrefs().getBoolFromSF();
    if (boolValue == true) {
      Timer(
          Duration(seconds: 5),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage())));
    } else {
      Timer(
          Duration(seconds: 5),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LanguageSelection())));
    }
  }
  // endregion
}