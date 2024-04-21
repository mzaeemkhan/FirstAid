import 'dart:convert';

import 'package:first_aid/data/network/api/request.dart';
import 'package:first_aid/models/helper_models/language_model.dart';
import 'package:first_aid/models/response/EmergencyContactModel.dart';
import 'package:first_aid/models/response/FirstAidModel.dart';
import 'package:first_aid/shared/constants/string_assets.dart';
import 'package:first_aid/shared/util/util.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstAidController extends GetxController {
  List<LanguageModel> languageOptions = new List<LanguageModel>.empty(growable: true);
  LanguageModel selectedLanguage;

  bool isFirstAidDataLoading = true;
  List<FirstAidModel> firstAidList = new List<FirstAidModel>.empty(growable: true);

  bool languageEnglish = true;

  bool isEmergencyContactLoading = true;
  List<EmergencyContactModel> emergencyContactList = new List<EmergencyContactModel>.empty(growable: true);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLanguageOptions().then((value){
      if(languageOptions.isNotEmpty){
        languageOptions.clear();
      }
      languageOptions.addAll(value);
      languageOptions.forEach((element) {
        if(element.isSelected){
          selectedLanguage = element;
        }
      });

      changeLanguageIdentifier();
    });
  }

  void fetchFirstAidData() {
    isFirstAidDataLoading = true;
    update();

    Request request = Request(url: StringAssets.firstAidUrl);
    request.get().then((value) async {
      if(value.statusCode == 200) {
        var result = await json.decode(value.body);
        if(result !=  null){
          if(firstAidList.isNotEmpty){
            firstAidList.clear();
          }

          var res = result as List;
          List<FirstAidModel> resultListFromResult = res.map((x) => FirstAidModel.fromJson(x)).toList();
          firstAidList.addAll(resultListFromResult);
        }
        else{
          errorToastMessages("Server response is empty.");
        }
      }
      else if(value.statusCode == StringAssets.timeoutCode){
        errorToastMessages("Couldn't fetch data, timeout.");
      }
      else if(value.statusCode == StringAssets.internetIssueCode){
        errorToastMessages("Couldn't fetch data, please check your internet.");
      }
      else if(value.statusCode == StringAssets.errorCode){
        errorToastMessages("Couldn't fetch data.");
      }
      else{
        errorToastMessages("Couldn't fetch data.");
      }
      isFirstAidDataLoading = false;
      update();
    });
  }

  void fetchEmergencyContactData() {
    if(emergencyContactList.isEmpty){
      isEmergencyContactLoading = true;
      update(['contact_screen'], true);
    }

    Request request = Request(url: StringAssets.emergencyContactUrl);
    request.get().then((value) async {
      if(value.statusCode == 200) {
        var result = await json.decode(value.body);
        if(result !=  null){
          if(emergencyContactList.isNotEmpty){
            emergencyContactList.clear();
          }
          var res = result as List;
          List<EmergencyContactModel> resultListFromResult = res.map((x) => EmergencyContactModel.fromJson(x)).toList();
          emergencyContactList.addAll(resultListFromResult);

          print("emergencyContactList -> ${emergencyContactList.length}");
        }
        else{
          errorToastMessages("Server response is empty.");
        }
      }
      else if(value.statusCode == StringAssets.timeoutCode){
        errorToastMessages("Couldn't fetch data, timeout.");
      }
      else if(value.statusCode == StringAssets.internetIssueCode){
        errorToastMessages("Couldn't fetch data, please check your internet.");
      }
      else if(value.statusCode == StringAssets.errorCode){
        errorToastMessages("Couldn't fetch data.");
      }
      else{
        errorToastMessages("Couldn't fetch data.");
      }
      isEmergencyContactLoading = false;
      update(['contact_screen'], true);
    });
  }

  void saveSelectedLanguage(int languageId)  async {
    if(languageOptions.isNotEmpty){
      List<LanguageModel> latestList = List.empty(growable: true);

      languageOptions.forEach((element) {
        if(element.id == languageId){
          LanguageModel languageModel = new LanguageModel(id: element.id, name: element.name, languageCode: element.languageCode, countryCode: element.countryCode, isSelected: true);
          latestList.add(languageModel);
        }
        else{
          LanguageModel languageModel = new LanguageModel(id: element.id, name: element.name, languageCode: element.languageCode, countryCode: element.countryCode, isSelected: false);
          latestList.add(languageModel);
        }
      });

      languageOptions.clear();
      languageOptions.addAll(latestList);
      languageOptions.forEach((element) {
        if(element.isSelected){
          selectedLanguage = element;
        }
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(StringAssets.languageOptionKey, json.encode(List<dynamic>.from(languageOptions.map((x) => x.toJson()))));

      updateLocale(languageOptions);

      update();
    }
  }

  void selectLanguage(LanguageModel languageModel){
    selectedLanguage = languageModel;
    update();
    saveSelectedLanguage(selectedLanguage.id);
  }
}