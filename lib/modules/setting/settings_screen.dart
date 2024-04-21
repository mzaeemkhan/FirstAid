import 'package:first_aid/common_controllers/first_aid_controller.dart';
import 'package:first_aid/models/helper_models/language_model.dart';
import 'package:first_aid/modules/widgets/custom_app_bar.dart';
import 'package:first_aid/modules/widgets/rounded_button.dart';
import 'package:first_aid/modules/widgets/text_widget.dart';
import 'package:first_aid/shared/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/app_colors.dart';
import '../widgets/common_widgets.dart';

class SettingsScreen extends StatefulWidget {

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // region Variables
  FirstAidController firstAidController;
  // endregion

  // region initState Method
  @override
  void initState() {
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
      return GetBuilder<FirstAidController>(
        builder: (_) => Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: customAppBar(
              "settings".tr,
            Icons.arrow_back,
              (){Navigator.pop(context, false);},
            [],
            null
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: myText("common".tr, TextAlign.start, AppColors.primaryColor, 16, FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return GetBuilder<FirstAidController>(
                                  builder: (_) => StatefulBuilder(
                                      builder: (context, setState) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          elevation: 5.0,
                                          backgroundColor: AppColors.whiteColor,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 20.0),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(child: myText("select_language".tr, TextAlign.start, AppColors.blackColor, 16, FontWeight.bold)),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  languageDropdown(),
                                                  SizedBox(height: 10),
                                                  MyRoundedButton(
                                                    text: "ok".tr,
                                                    textSize: 16.0,
                                                    textColor: AppColors.whiteColor,
                                                    colorButton: AppColors.primaryColor,
                                                    colorSplash: AppColors.primaryLightColor,
                                                    press: () async {
                                                      Navigator.of(context).pop();
                                                    },
                                                    edgeInsetsGeometry: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                                    radius: 5.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5,
                                  color: AppColors.blackColor
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.transparent
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              iconWidget(Icons.language, AppColors.primaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myText("language".tr, TextAlign.start, AppColors.blackColor, 14, FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myText(firstAidController.selectedLanguage != null ? firstAidController.selectedLanguage.name.tr : "", TextAlign.start, AppColors.blackColor, 14, FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ),
      );
    }
  // endregion

//region language selector dropdown
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