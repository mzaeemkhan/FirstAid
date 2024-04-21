import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/data/local/shared_preference/shared_prefs.dart';
import 'package:first_aid/models/helper_models/language_model.dart';
import 'package:first_aid/modules/widgets/rounded_button.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/app_colors.dart';
import 'package:first_aid/shared/constants/app_theme.dart';
import 'package:flutter/material.dart';
import '../home/main_page.dart';
import 'package:get/get.dart';

class LanguageSelection extends StatefulWidget {

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  // region Variables
  FirstAidController firstAidController;
  // endregion

  // region initState Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    try{
      firstAidController = Get.find();
    }catch(exception){
      firstAidController = Get.put(FirstAidController());
    }
  }
  // endregion

  // region build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: myText("select_language".tr, TextAlign.center, AppColors.primaryColor, 16, FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  languageDropdown(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.0),
                          child: MyRoundedButton(
                            text: "ok".tr,
                            textSize: 16.0,
                            textColor: AppColors.whiteColor,
                            colorButton: AppColors.primaryColor,
                            colorSplash: AppColors.primaryLightColor,
                            press: () async {
                              await SharedPrefs().setBoolToSF(true);

                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => MainPage()));
                            },
                            edgeInsetsGeometry: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                            radius: 5.0,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // endregion

  //region Language selection dropdown
  Container languageDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      width: MediaQuery.of(context).size.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          border: Border.all(
              width: 0.5,
              color: AppColors.blackColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: AppColors.whiteColor
      ),
      child: DropdownButton<LanguageModel>(
        hint:  myText("select_language".tr, TextAlign.left, AppColors.blackColor, 16, FontWeight.normal),
        value: firstAidController.selectedLanguage,
        isExpanded: true,
        isDense: false,
        dropdownColor: AppColors.whiteColor,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
            fontFamily: getFontAccordingToLanguage()
        ),
        icon: Icon(Icons.keyboard_arrow_down, size: 24.0, color: AppColors.blackColor,),
        underline: Container(
          height: 1.0,
          color: AppColors.whiteColor,
        ),
        onChanged: (LanguageModel value) {
          firstAidController.selectLanguage(value);
        },
        items: firstAidController.languageOptions?.map((LanguageModel position) {
          return  DropdownMenuItem<LanguageModel>(
            value: position,
            child: Container(
              color: AppColors.whiteColor,
              child: myText(position.name.tr, TextAlign.left, AppColors.blackColor, 16, FontWeight.normal),
            ),
          );
        })?.toList() ?? [],
      ),
    );
  }
  //endregion
}
