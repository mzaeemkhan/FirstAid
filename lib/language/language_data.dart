import 'package:first_aid/shared/constants/font_family.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_font_family': FontFamily.poppinsPoppinsRegular,
      'first_aid': 'First Aid',
      'select_language': 'Select language',
      'language': 'Language',
      'english': 'English',
      'urdu': 'Urdu',
      'common': 'Common',
      'settings': 'Settings',
      'ok': 'OK',
      'about_us': 'About Us',
      'search_hint': "Search...",
      'no_result_found': 'Nothing found.',
      'emergency_contacts': 'Emergency Contacts',
      'about': 'About @name',
    },
    'ur_PK': {
      'app_font_family': FontFamily.urduJameelNooriNastaleeqRegular,
      'first_aid': 'ابتدائی طبی امداد',
      'select_language': 'زبان منتخب کریں۔',
      'language': 'زبان',
      'english': 'انگریزی',
      'urdu': 'اردو',
      'common': 'عام',
      'settings': 'ترتیبات',
      'ok': 'ٹھیک ہے',
      'about_us': 'ہمارے بارے میں',
      'search_hint': "تلاش کریں...",
      'no_result_found': 'کچھ نہیں ملا.',
      'emergency_contacts': 'ہنگامی رابطے',
      'about': '@name کے بارے میں',
    }
  };
}