import 'package:first_aid/shared/constants/string_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  //region is Language Added
  setBoolToSF(bool value) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    bool boolValue = value;
    _sharedPrefs.setBool(StringAssets.spKeyLangAdded, boolValue);
  }

  Future<bool> getBoolFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = false;
    if (prefs.containsKey(StringAssets.spKeyLangAdded)) {
      boolValue = prefs.getBool(StringAssets.spKeyLangAdded);
    }
    return boolValue;
  }
  // endregion

  //region is Language English
  setIsEnglish(bool value) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    bool boolValue = value;
    _sharedPrefs.setBool(StringAssets.spKeyIsEnglish, boolValue);
  }

  Future<bool> getIsEnglish() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = false;
    if (prefs.containsKey(StringAssets.spKeyIsEnglish)) {
      boolValue = prefs.getBool(StringAssets.spKeyIsEnglish);
    }
    return boolValue;
  }
  // endregion

  //region Language
  setLanguageToSF(String value) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString(StringAssets.spKeyLanguage, value);
  }

  Future<String> getLanguageFromSF() async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    String language = "";
    if (_sharedPrefs.containsKey(StringAssets.spKeyLanguage)) {
      language = _sharedPrefs.getString(StringAssets.spKeyLanguage);
    }
    return language;
  }
  // endregion
}